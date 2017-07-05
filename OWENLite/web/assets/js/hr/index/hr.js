/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var metricList;
var nodes;
var edges;
var sentimentList;
var selfPerceptionList;
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

    $("#dropdown_relationship").on("change", function () {
//        console.log(parseInt($(this).find(":selected").val()));
        plotCytoNetwork("relationshipNetwork", parseInt($(this).find(":selected").val()));
    });

    go();
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
            metricList = JSON.parse(response.metricList);
            sentimentList = JSON.parse(response.sentimentList);
            selfPerceptionList = JSON.parse(response.selfPerceptionList);
            sentimentScore = JSON.parse(response.sentimentScore);
            indexValue = JSON.parse(response.indexValue);
            keyPeople = JSON.parse(response.keyPeople);
            selfPerception = JSON.parse(response.selfPerception);
            wordCloud = JSON.parse(response.wordCloud);
            plotRelationship();
//            plotSentiment();
//            plotComponent();
        },
        error: function (resp, err) {
            console.log("unable to fetch data error messsage : " + err);
        }
    });
}

function plotRelationship() {

// merging multiple datasets into one
    var joined = {};
    metricList.forEach(function (u) {
        joined[u.relId] = u;
    });

    indexValue.forEach(function (u) {
        joined[u.relId].indexValue = u.indexValue;
        joined[u.relId].explanation = u.explanation;
        joined[u.relId].action = u.action;
        joined[u.relId].responseCount = u.responseCount;
    });

    keyPeople.forEach(function (u) {
        joined[u.relId].keyPeople = u.keyPeople;
    });

    var dataSet = [];
    for (var relId in joined) {
        dataSet.push(joined[relId]);
    }

    plotCytoNetwork("relationshipNetwork", 1);
}

function plotCytoNetwork2(chartId) {
    cytoscape({
        container: document.getElementById(chartId),
        layout: {
            name: 'circle',
            padding: 10
        },
        style: cytoscape.stylesheet()
                .selector('node')
                .css({
                    'shape': 'data(faveShape)',
                    'width': 'mapData(weight, 40, 80, 20, 60)',
                    'content': 'data(name)',
                    'text-valign': 'center',
                    'text-outline-width': 2,
                    'text-outline-color': 'data(color)',
                    'background-color': 'data(color)',
                    'color': '#fff'
                })
                .selector('edge')
                .css({
                    'curve-style': 'bezier',
                    'opacity': 0.666,
                    'width': 'mapData(strength, 70, 100, 2, 6)',
                    'target-arrow-shape': 'triangle',
                    'source-arrow-shape': 'circle',
                    'line-color': 'data(color)',
                    'source-arrow-color': 'data(color)',
                    'target-arrow-color': 'data(color)'
                }),
        elements: {
            nodes: [
                {data: {id: 'j', name: 'Jerry', weight: 65, color: '#6FB1FC', faveShape: 'triangle'}},
                {data: {id: 'e', name: 'Elaine', weight: 45, color: '#EDA1ED', faveShape: 'ellipse'}},
                {data: {id: 'k', name: 'Kramer', weight: 75, color: '#86B342', faveShape: 'octagon'}},
                {data: {id: 'a', name: 'a', weight: 65, color: '#ff9800', faveShape: 'square'}},
                {data: {id: 'b', name: 'b', weight: 25, color: '#ff9800', faveShape: 'square'}},
                {data: {id: 'c', name: 'c', weight: 35, color: '#ff9800', faveShape: 'square'}},
                {data: {id: 'd', name: 'd', weight: 45, color: '#ff9800', faveShape: 'square'}},
                {data: {id: 'e', name: 'e', weight: 55, color: '#ff9800', faveShape: 'square'}},
                {data: {id: 'f', name: 'f', weight: 65, color: '#ff9800', faveShape: 'square'}},
                {data: {id: 'g', name: 'George', weight: 70, color: '#F5A45D', faveShape: 'rectangle'}}
            ],
            edges: [
                {data: {source: 'j', target: 'e', color: '#6FB1FC', strength: 90}},
                {data: {source: 'a', target: 'k', color: '#6FB1FC', strength: 70}},
                {data: {source: 'b', target: 'g', color: '#6FB1FC', strength: 80}},
                {data: {source: 'c', target: 'j', color: '#EDA1ED', strength: 95}},
                {data: {source: 'd', target: 'j', color: '#86B342', strength: 100}},
                {data: {source: 'e', target: 'e', color: '#86B342', strength: 100}},
                {data: {source: 'f', target: 'g', color: '#86B342', strength: 100}},
                {data: {source: 'g', target: 'j', color: '#F5A45D', strength: 90}}
            ]
        },

        ready: function () {
            window.cy = this;
        }
    });

}

function plotCytoNetwork(chartId, selectedRelationship) {
//    var selectedRelationship = $('#dropdown_relationship').find(':selected').attr('value');
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

//Rename Source and Target as From and To respectively, in order for cytoscape to accept them while plotting edges
    for (var i = 0; i < arrEdges.length; i++) {
        arrEdges[i].data["source"] = arrEdges[i].data["from"];
        arrEdges[i].data["target"] = arrEdges[i].data["to"];
//        delete arrEdges[i].data["from"];
//        delete arrEdges[i].data["to"];
    }


    var cy = cytoscape({
        container: container,
        layout: {
            name: 'circle'
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
                    y: 100,
                    borderWidth: 0,
                    useHTML: true
                }
            }
        }
    };

    var chartSpeed = Highcharts.chart('HC_Gauge', Highcharts.merge(gaugeOptions, {
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

function plotHCTable(jsonData) {
    var length = Object.keys(jsonData).length;

    $("#relationshipListOfPeople tbody td").empty();
    $(".hiddenRow").css("display", "none");
    for (var i = 0; i < length; i++) {
        var clone = $('#template').clone(true).attr('class', 'hiddenRow');
        clone.find('.people').html(jsonData[i]['people']);
//        clone.find('.association').html(jsonData[i]['association']);
        clone.appendTo('table');
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
        wait: 15,
        shuffle: false,
//        color: '#9e9e9e'
        color: function (word, weight, fontSize, distance, theta, sentiment) {
            if (sentiment === "positive") {
                return "#64DD17";
            } else if (sentiment === "neutral") {
                return "#FFD600";
            } else if (sentiment === "negative") {
                return "#DD2C00";
            }
        }
    });
}