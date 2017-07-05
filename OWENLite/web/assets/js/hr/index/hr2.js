/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//var metricList;
var nodes;
var edges;
//var sentimentList;
//var selfPerceptionList;
var sentimentScore;
var indexValue;
var keyPeople;
var selfPerception;
var wordCloud;

//$(window).on("load", function () {
$(document).ready(function () {
    var slider = $("#slider").slideReveal({
        trigger: $("#trigger"),
        position: "left",
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

    $(".mdl-tabs__tab-bar").on("click", function () {
        if ($(".mdl-tabs__tab-bar").find(".mdl-tabs__tab.is-active").attr("href") === "#panelRelationship") {
            setTimeout(function () {
                plotRelationshipCharts(false);
            }, 10);
        }
    });

//    $("#dropdown_theme").on("change", function () {
//        var selectedOption = $("#dropdown_theme").parent().find(".mdl-selectfield__box-value").text();
//        var optionValue = $('#dropdown_theme option').filter(function () {
//            return $(this).html() === selectedOption;
//        }).val();
//        plotRelationshipCharts(optionValue);
//    });

//    $("#dropdown_component").on("change", function () {
//        var selectedOption = $("#dropdown_component").parent().find(".mdl-selectfield__box-value").text();
//        var optionValue = $('#dropdown_component option').filter(function () {
//            return $(this).html() === selectedOption;
//        }).val();
//        plotRelationshipCharts(optionValue);
//    });
});

function go() {
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
//            metricList = JSON.parse(response.metricList);
//            sentimentList = JSON.parse(response.sentimentList);
//            selfPerceptionList = JSON.parse(response.selfPerceptionList);
            sentimentScore = JSON.parse(response.sentimentScore);
            indexValue = JSON.parse(response.indexValue);
            keyPeople = JSON.parse(response.keyPeople);
            selfPerception = JSON.parse(response.selfPerception);
            wordCloud = JSON.parse(response.wordCloud);
            plotRelationship();
            plotSentiment();
            plotComponent();
        },
        error: function (resp, err) {
            console.log("unable to fetch data error messsage : " + err);
        }
    });
}

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
            wordCloud = JSON.parse(response.wordCloud);
            plotRelationshipCharts(isFirstTime);
            plotSentimentCharts(isFirstTime);

        },
        error: function (resp, err) {
            console.log("unable to fetch data error messsage : " + err);
        }
    });
}

function plotRelationshipCharts(isFirstTime) {
    var optionValue;
    if (isFirstTime) {
        optionValue = parseInt($("#dropdown_relationship").find("option:first-child").val());
    } else {
        var selectedOption = $("#dropdown_relationship").parent().find(".mdl-selectfield__box-value").text();
        optionValue = parseInt($('#dropdown_relationship option').filter(function () {
            return $(this).html() === selectedOption;
        }).val());
    }

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

    cy.elements().qtip({
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
    $(".hiddenRow").css("display", "none");
    var j = 1;
    for (var i = 0; i < length; i++) {
        var clone = $('#template').clone(true).attr('class', 'hiddenRow');
        clone.find('.people').html(jsonData[j.toFixed(1)]);
        j++;
        clone.appendTo('table');
    }
}

function plotSentimentCharts(isFirstTime) {
    var optionValue;
    if (isFirstTime) {
        optionValue = parseInt($("#dropdown_sentiment").find("option:first-child").val());
    } else {
        var selectedOption = $("#dropdown_sentiment").parent().find(".mdl-selectfield__box-value").text();
        optionValue = parseInt($('#dropdown_sentiment option').filter(function () {
            return $(this).html() === selectedOption;
        }).val());
    }

    // response count
    $("#sentimentResponses").empty();
    $("#sentimentResponses").append(sentimentScore[optionValue].responseCount);

    // sentiment gauge
    var data = [sentimentScore[optionValue].metricValue];
    plotHCGauge(data);

    // sentiment distribution




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
            height: 200,
//            width: 400,
            spacingTop: 0,
            spacingLeft: 0,
            spacingRight: 0,
            spacingBottom: 0,
            margin: [0, 0, 0, 0]
        },
        title: null,
        pane: {
            center: ['50%'],
            size: '70%',
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
                [0.9, '#64DD17']
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
                    y: 75
                    ,
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
                text: 'null'
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
                    valueSuffix: ' revolutions/min'
                }
            }]

    }));
}

function plotWordCloud2(chartId) {
    var list = [];
    for (var key in wordCloud) {
        var val = wordCloud[key];
        console.log(val);
        var array = [val.word, val.weight];
//        array.push[val.word];
//        array.push[val.weight];
        list.push(array);
    }

    WordCloud(document.getElementById(chartId), {
        list: list,
        fontFamily: 'Roboto',
        backgroundColor: '#ffffff',
        rotateRatio: 0,
//        shape: 'pentagon',
//        gridSize: 5,
        minSize: 8,
        weightFactor: 5,
//        clearCanvas: true,
        drawOutOfBound: false,
        wait: 25,
        shuffle: false,
        color: function (word, weight) {
            return (weight > 10) ? '#00ff00' : '#c09292';
        }

    });
}

function plotHCStackedBar(containerId, seriesData) {
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
            shared: true
        },
        title: null,
        xAxis: {
            categories: ['Org', 'Team'],
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






function plotSentiment() {
    var joined = {};

    sentimentList.forEach(function (u) {
        joined[u.relId] = u;
    });

    sentimentScore.forEach(function (u) {
        joined[u.relId].metricValue = u.metricValue;
        joined[u.relId].explanation = u.explanation;
        joined[u.relId].action = u.action;
        joined[u.relId].responseCount = u.responseCount;
    });

//    wordCloud.forEach(function (u) {
////        console.log(u);
//        joined[u.relId].wordCloud = u;
//    });

    var dataSet = [];
    for (var relId in joined) {
        dataSet.push(joined[relId]);
    }

    var cf = crossfilter(dataSet);

    var rel = cf.dimension(function (d) {
        return d.relName;
    });
    var relGroup = rel.group();
//    plotDcDropdown("dropdown_theme", rel, relGroup, ".openText");

    var responseDim = cf.dimension(function (d) {
        return d.responseCount;
    });
    plotDcNumber("openTextResponses", responseDim, responseDim.group(), ".openText");

    var sentimentImageDim = cf.dimension(function (d) {
        return d.metricValue;
    });
    plotDcNumber("openTextImage", sentimentImageDim, sentimentImageDim.group(), ".openText");

    plotWordCloud("openTextWordCloud", ".openText");
    $("#dropdown_theme select").on('change', function () {
        plotWordCloud("openTextWordCloud", ".openText");
    });
    var explanationDim = cf.dimension(function (d) {
        return d.explanation;
    });
    plotTableExplanation("openTextExplanation", explanationDim, ".openText");
}

function plotComponent() {

    var cf = crossfilter(selfPerception);

    var rel = cf.dimension(function (d) {
        return d.relName;
    });
    var relGroup = rel.group();
//    plotDcDropdown("dropdown_component", rel, relGroup, ".meSection");

    var responseDim = cf.dimension(function (d) {
        return d.responseCount;
    });
    plotDcNumber("meSectionResponses", responseDim, responseDim.group(), ".meSection");

    var distributionDim = cf.dimension(function (d) {
        return d.level;
    });

//    var stronglyAgreeGroup = distributionDim.group().reduceSum(function (d) {
//        return d.stronglyAgree;
//    });
//    var agreeGroup = distributionDim.group().reduceSum(function (d) {
//        return d.agree;
//    });
//    var neutralGroup = distributionDim.group().reduceSum(function (d) {
//        return d.neutral;
//    });
//    var disagreeGroup = distributionDim.group().reduceSum(function (d) {
//        return d.disagree;
//    });
//    var stronglyDisagreeGroup = distributionDim.group().reduceSum(function (d) {
//        return d.stronglyDisagree;
//    });
    var stronglyAgreeDim = cf.dimension(function (d) {
        return d.stronglyAgree;
    });
    var stronglyAgreeGroup = stronglyAgreeDim.group();
    var agreeDim = cf.dimension(function (d) {
        return d.agree;
    });
    var agreeGroup = agreeDim.group();
    var neutralDim = cf.dimension(function (d) {
        return d.neutral;
    });
    var neutralGroup = neutralDim.group();
    var disagreeDim = cf.dimension(function (d) {
        return d.disagree;
    });
    var disagreeGroup = disagreeDim.group();
    var stronglyDisagreeDim = cf.dimension(function (d) {
        return d.stronglyDisagree;
    });
    var stronglyDisagreeGroup = stronglyDisagreeDim.group();

//    plotDcStackedBar("meSectionDistribution", distributionDim, distributionGroup, "meSection");
    plotStackedBar("meSectionDistribution", distributionDim, stronglyAgreeGroup, agreeGroup, neutralGroup, disagreeGroup, stronglyDisagreeGroup);

    var explanationDim = cf.dimension(function (d) {
        return d.explanation;
    });
    plotTableExplanation("meSectionExplanation", explanationDim, ".meSection");
}

function plotWordCloud(chartId, panelId) {
    var selectedTheme = $('#dropdown_theme select').find(':selected').attr('value');
    var selectedRel = 0;
    if (selectedTheme === "theme1") {
        selectedRel = 5;
    } else if (selectedTheme === "theme2") {
        selectedRel = 6;
    } else if (selectedTheme === "theme3") {
        selectedRel = 7;
    }
    var cf = crossfilter(wordCloud);

    var wordCloudDim = cf.dimension(function (d) {
        if (selectedRel !== 0) {
            if (d.relId === selectedRel) {
                return d.word;
            }
        } else {
            return d.word;
        }
    });
    var wordCloudGroup = wordCloudDim.group().reduceSum(function (d) {
        if (selectedRel !== 0) {
            if (d.relId === selectedRel) {
                return d.weight;
            }
        } else {
            return d.weight;
        }

    });

    var wordcloudChart = dc.wordcloudChart("#" + chartId, panelId);
    wordcloudChart.options({
        height: 282,
        width: 573,
        minY: -10,
        minX: -50,
        relativeSize: 20,
        dimension: wordCloudDim,
        group: wordCloudGroup,
        valueAccessor: function (d) {
            return d.value;
        },
        title: function (d) {
            return [d.key, 'Word Count: ' + d.value].join('\n');
        }
    });

    wordcloudChart.render();
}