/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



var nodes;
var edges;
var sentimentScore;
var indexValue;
var keyPeople;
var selfPerception;
var sentimentDistribution;
var wordCloud;
var flag = true;

$(document).ready(function () {
    var slider = $("#slider").slideReveal({
        trigger: $("#trigger"),
        position: "left",
//        width: "18%",
        push: false,
        top: 64,
        show: function (slider, trigger) {
            $("#trigger i").text("close");
//            $("#slider").css("display", "block");
        },
        hide: function (slider, trigger) {
            $("#trigger i").text("menu");
//            $("#slider").css("display", "none");
        }
    });

    fetchData(true);

    $("#dropdown_relationship").on("change", function () {
        plotRelationshipCharts(false);
    });
    $("#dropdown_sentiment").on("change", function () {
        plotSentimentCharts(false);
    });
    $("#dropdown_component").on("change", function () {
        plotComponentCharts(false);
    });

    $(".mdl-tabs__tab-bar").on("click", function () {
        var selectedTab = $(".mdl-tabs__tab-bar").find(".mdl-tabs__tab.is-active").attr("href");
        if (selectedTab === "#panelRelationship") {
            setTimeout(function () {
                plotRelationshipCharts(false);
            }, 10);
        } else if (selectedTab === "#panelSentiment" && flag) {
            plotSentimentCharts(true);
            plotWordCloud("sentimentWordCloud", wordCloud[fetchOptionValue(flag, "dropdown_sentiment")]);
            flag = false;
        }
    });
    $("#slider").css("display", "block");

    setTimeout(function () {
//Check if wordcloud is empty. If yes, then plot all sentiment charts all over again
        if ($("#sentimentWordCloud").is(':empty')) {
            plotSentimentCharts(true);
        }
    }, 1000);

});

function fetchData(isFirstTime) {
    var funcId = $('#dropdown_function option:selected').val();
    var posId = $('#dropdown_position option:selected').val();
    var locId = $('#dropdown_location option:selected').val();
    var jsonObj = {
        "funcId": funcId,
        "posId": posId,
        "locId": locId
    };
    var postData = {'jsonObj': JSON.stringify(jsonObj)};
    jQuery.ajax({
        type: "POST",
        url: "../hr/fetchData.jsp",
        data: postData,
        async: false,
        success: function (resp) {
            var response = JSON.parse(resp);
            nodes = JSON.parse(response.nodes);
            edges = JSON.parse(response.edges);
            sentimentScore = JSON.parse(response.sentimentScore);
            indexValue = JSON.parse(response.indexValue);
            keyPeople = JSON.parse(response.keyPeople);
            selfPerception = JSON.parse(response.selfPerception);
            sentimentDistribution = JSON.parse(response.sentimentDistribution);
            wordCloud = JSON.parse(response.wordCloud);

            plotRelationshipCharts(isFirstTime);
            plotSentimentCharts(isFirstTime);
            plotComponentCharts(isFirstTime);

        },
        error: function (resp, err) {
            console.log("unable to fetch data error messsage : " + err);
        }
    });
}

function fetchOptionValue(isFirstTime, dropdownName) {
    var optionValue = "";
    if (isFirstTime) {
        optionValue = parseInt($("#" + dropdownName).find("option:first-child").val());
    } else {
        var selectedOption = $("#" + dropdownName).parent().find(".mdl-selectfield__box-value").text();
        optionValue = parseInt($('#' + dropdownName + ' option').filter(function () {
            return $(this).html() === selectedOption;
        }).val());
    }
    return optionValue;
}
function plotRelationshipCharts(isFirstTime) {
    var optionValue = fetchOptionValue(isFirstTime, "dropdown_relationship");

    // response count
    $("#relationshipResponses").empty();
    $("#relationshipResponses").append(indexValue[optionValue].responseCount);

    // network diagram
    if ($(".mdl-tabs__tab-bar").find(".mdl-tabs__tab.is-active").attr("href") === "#panelRelationship") {
        plotCytoNetwork("relationshipNetwork", optionValue);
    }
    // index value
    $("#relationshipIndex").empty();
    $("#relationshipIndex").append(indexValue[optionValue].indexValue);

    // key people
    plotHCTable(keyPeople[optionValue]);

    // action
    $("#relationshipAction").empty();
    $("#relationshipAction").append(indexValue[optionValue].action);

    // explanation
    $("#relationshipExplanation").empty();
    $("#relationshipExplanation").append(indexValue[optionValue].explanation);
}

function plotCytoNetwork(chartId, selectedRelationship) {
    var container = document.getElementById(chartId);

//Filter Edges for selectedRelationshipType
    var filteredEdges = [];
    $.each(edges, function () {
        if (this.relId === selectedRelationship) {
            filteredEdges.push(this);
        }
    });

//Create array of nodes
    var arrNodes = [];
    for (var i = 0; i < nodes.length; i++) {
        arrNodes.push({
            group: "nodes",
            data: nodes[i]
        });
    }

//Create array of edges, based on filtered edges
    var arrEdges = [];
    for (var i = 0; i < filteredEdges.length; i++) {
        arrEdges.push({
            group: "edges",
            data: filteredEdges[i]
        });
    }
    var cy = cytoscape({
        container: container,
        minZoom: 0.5,
        maxZoom: 2,
        zoomingEnabled: true,
        userZoomingEnabled: true,
        panningEnabled: true,
        userPanningEnabled: true,
        hideEdgesOnViewport: false,
        hideLabelsOnViewport: true,
        layout: {
            name: 'grid'
        },
        style: [
            {
                selector: 'node',
                style: {
//                    shape: 'hexagon',
//                    'background-color': 'red',
                    content: 'data(firstName)'
                }
            }, {
                selector: 'edge',
                style: {
//                    'background-color': 'red',
                    'curve-style': 'bezier',
                    'target-arrow-shape': 'triangle',
                    'source-arrow-shape': 'circle',
                    'opacity': 0.666,
                    'width': 'data(weight)'
                }
            }],
        elements: {
            nodes: arrNodes,
            edges: arrEdges
        }
    });

    cy.elements("node").qtip({
        content: function () {
//            return 'Example qTip on ele ' + this.id();
            return this.data().lastName;
        },
        position: {
            my: 'top center',
            at: 'bottom center'
        },
        style: {
            classes: 'qtip-bootstrap',
            tip: {
                width: 16,
                height: 8
            }
        }
    });
    cy.resize();
}

function plotHCTable(jsonData) {
    var length = Object.keys(jsonData).length;

    $("#relationshipListOfPeople tbody td").empty();
    $("#relationshipListOfPeople .hiddenRow").css("display", "none");
    var j = 1;
    for (var i = 0; i < length; i++) {
        var clone = $('#template').clone(true).attr('class', 'hiddenRow');
        clone.find('.people').html(jsonData[j.toFixed(1)]);
        j++;
        clone.appendTo('#relationshipListOfPeople');
    }
}

function plotSentimentCharts(isFirstTime) {
    var optionValue = fetchOptionValue(isFirstTime, "dropdown_sentiment");

    // response count
    $("#sentimentResponses").empty();
    $("#sentimentResponses").append(sentimentScore[optionValue].responseCount);

    // sentiment gauge
    var data = [sentimentScore[optionValue].metricValue];
    plotHCGauge(data);

    // sentiment distribution
    plotStackedSentiment("sentimentDistribution", sentimentDistribution[optionValue]);

    // word cloud
    plotWordCloud("sentimentWordCloud", wordCloud[optionValue]);

    //Word association
    plotWordAssociation(wordCloud[optionValue]);

    // action
    $("#sentimentAction").empty();
    $("#sentimentAction").append(sentimentScore[optionValue].action);

    // explanation
    $("#sentimentExplanation").empty();
    $("#sentimentExplanation").append(sentimentScore[optionValue].explanation);
}

function plotHCGauge(dataValue) {
    var gaugeOptions = {
        chart: {
            type: 'solidgauge',
            height: null,
            width: null,
            spacingTop: 0,
            spacingLeft: 0,
            spacingRight: 0,
            spacingBottom: 0,
            margin: [0, 0, 0, 0],
            style: {
                fontFamily: 'Roboto'
            }
        },
        title: null,
        pane: {
            center: ['50%', '75%'],
            size: '150%',
            startAngle: -90,
            endAngle: 90,
            background: {
                backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
                innerRadius: '60%',
                outerRadius: '100%',
                shape: 'arc'
            }
        },
        tooltip: {
            enabled: false
        },
        // the value axis
        yAxis: {
            stops: [
                [0.1, '#DD2C00'],
                [0.5, '#FFD600'],
                [0.9, '#00C853']
            ],
            lineWidth: 0,
            minorTickInterval: null,
//            tickAmount: 1,
            tickInterval: 5,
            tickPixelInterval: null,
            title: {
                y: -70
            },
            labels: {
                y: 16
            }
        },
        plotOptions: {
            solidgauge: {
                dataLabels: {
                    y: -30,
                    borderWidth: 0,
                    useHTML: true
                }
            }
        }
    };

    var chartSpeed = Highcharts.chart('sentimentGauge', Highcharts.merge(gaugeOptions, {
        yAxis: {
            min: 0,
            max: 5,
            title: {
                text: null
            }
        },
        credits: {
            enabled: false
        },
        series: [{
//                name: 'RPM',
                data: dataValue,
                dataLabels: {
                    align: "center",
                    enabled: true,
                    format: '<div style="text-align:center"><span style="font-size:24px;font-family:Roboto;font-weight:400;color:' +
                            ((Highcharts.theme && Highcharts.theme.contrastTextColor) || '#9E9E9E') + '">{y:.1f}</span><br/>'
//                            '<span style="font-size:12px;color:silver">* 1000 / min</span></div>'
                },
                tooltip: {
//                    valueSuffix: ' revolutions/min'
                }
            }]

    }));
}

function plotStackedSentiment(containerId, seriesData) {
//    Highcharts.chart('HCStacked_Bar', {
    Highcharts.chart(containerId, {
        chart: {
            type: 'bar'
//            height: 130,
//            width: 300
        },
//        colors: ['#DD2C00', '#FFD600', '#64DD17'],
        credits: {
            enabled: false
        },
        tooltip: {
            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
            shared: false
        },
        title: null,
        xAxis: {
            categories: ['Sentiment'],
            labels:
                    {
                        enabled: false
                    }
        },
        yAxis: {
//            min: 0,
            title: {
                text: null
            },
            labels: {
                style: {
                    color: "#9E9E9E",
                    fontWeight: 400
                }
            }
        },
        legend: {
            enabled: false,
            reversed: true,
            layout: 'horizontal',
            align: 'center',
            y: -20,
            itemStyle: {
                color: "#9E9E9E",
                fontWeight: 400
            }
//            verticalAlign: 'bottom',
//            floating: true
        },
        plotOptions: {
            series: {
                stacking: 'percent',
                colorByPoint: true,
                dataLabels: {
                    enabled: false,
                    crop: false,
                    overflow: 'none'
                }
            }
        },
        series: seriesData
    });
}

function plotWordAssociation(jsonData) {
    var length = jsonData.length;

    $("#HC_Table tbody td").empty();
    $("#HC_Table .hiddenRow").css("display", "none");
    for (var i = 0; i < length; i++) {
        var clone = $('#temp').clone(true).attr('class', 'hiddenRow');
        clone.find('.word').html(jsonData[i]['word']);
        clone.find('.association').html(jsonData[i]['association']);
        clone.appendTo('#HC_Table table');
    }
}

//Color by sentiment
function plotWordCloud(chartId, words) {
    var list = [];
//    var color;
    for (var key in words) {
        var val = words[key];
        var array = [val.word, val.frequency, val.sentiment];
        list.push(array);
    }
    WordCloud(document.getElementById(chartId), {
        list: list,
        fontFamily: 'Roboto',
        backgroundColor: '#ffffff',
        rotateRatio: 0,
//        shape: 'pentagon',
        gridSize: 5,
//        minSize: 1,
        weightFactor: 7,
        clearCanvas: true,
        drawOutOfBound: false,
        wait: 0,
        shuffle: false,
//        color: '#9e9e9e'
        color: function (word, weight, fontSize, distance, theta, sentiment) {
            if (sentiment === "positive") {
                return "#00C853";
            } else if (sentiment === "neutral") {
                return "#FFD600";
            } else if (sentiment === "negative") {
                return "#DD2C00";
            }
        }
    });
}

function plotComponentCharts(isFirstTime) {
    var optionValue = fetchOptionValue(isFirstTime, "dropdown_component");

    // response count
    $("#componentResponses").empty();
    $("#componentResponses").append(selfPerception[optionValue].responseCount);

    plotStackedComponent("componentDistribution", selfPerception[optionValue].series);

    // action
    $("#componentAction").empty();
    $("#componentAction").append(selfPerception[optionValue].action);

    // explanation
    $("#componentExplanation").empty();
    $("#componentExplanation").append(selfPerception[optionValue].explanation);
}

function plotStackedComponent(containerId, seriesData) {
//    Highcharts.chart('HCStacked_Bar', {
    Highcharts.chart(containerId, {
        chart: {
            type: 'bar'
//            height: 130,
//            width: 300
        },
        colors: ['#DD2C00', '#FFAB00', '#FFD600', '#AEEA00', '#00C853'],
        credits: {
            enabled: false
        },
        tooltip: {
            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
            shared: false
        },
        title: null,
        xAxis: {
            categories: ['Org', 'Team'],
            labels:
                    {
                        enabled: true
                    }
        },
        yAxis: {
//            min: 0,
            title: {
                text: null
            },
            labels: {
                style: {
                    color: "#9E9E9E",
                    fontWeight: 400
                }
            }
        },
        legend: {
            enabled: true,
            reversed: true,
            layout: 'horizontal',
            align: 'center',
            y: -20,
            itemStyle: {
                color: "#9E9E9E",
                fontWeight: 400
            }
//            verticalAlign: 'bottom',
//            floating: true
        },
        plotOptions: {
            series: {
                stacking: 'percent',
//                colorByPoint: true,
                dataLabels: {
                    enabled: false,
                    crop: false,
                    overflow: 'none'
                }
            }
        },
        series: seriesData
    });
}