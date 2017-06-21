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
    $('.filterPanel').Stickyfill();

//Smooth Scroll from Header
    var nav = $('a');
    if (nav.length) {
        // Add smooth scrolling to all links
        $("a").on('click', function (event) {
            // Make sure this.hash has a value before overriding default behavior
            if (this.hash !== "") {
                // Prevent default anchor click behavior
                event.preventDefault();
                // Store hash
                var hash = this.hash;
                if ($(hash).length) {
                    // Using jQuery's animate() method to add smooth page scroll
                    // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                    $('.mdl-layout__content').animate({
//                        scrollTop: $(hash).get(0).offsetTop
                        scrollTop: $(hash).offset().top
                    }, 800, function () {
                        // Add hash (#) to URL when done scrolling (default click behavior)
//                        window.location.hash = hash;
                    });
                } else {
//                    alert("Oops");
                    window.location.href = $(this).attr('href');
                }
            } // End if
        });
    }

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
            plotSentiment();
            plotComponent();
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

    var cf = crossfilter(dataSet);

    var rel = cf.dimension(function (d) {
        return d.relName;
    });
    var relGroup = rel.group();
    plotDcDropdown("dropdown_relationship", rel, relGroup, ".weSection");

    var index = cf.dimension(function (d) {
        return d.indexValue;
    });
    plotDcNumber("weSectionIndex", index, index.group(), ".weSection");

    var keyPeopleDim = cf.dimension(function (d) {
        return d.keyPeople;
    });
    plotTable("weSectionListOfPeople", keyPeopleDim, ".weSection");

    var explanationDim = cf.dimension(function (d) {
        return d.explanation;
    });
    plotTableExplanation("weSectionExplanation", explanationDim, ".weSection");

    var responseDim = cf.dimension(function (d) {
        return d.responseCount;
    });
    plotDcNumber("weSectionResponses", responseDim, responseDim.group(), ".weSection");


//    plotVisNetwork("weSectionNetwork", ".weSection");
    plotCytoNetwork("weSectionNetwork");
}

//Used across Network, Open Text and Self Perception to select relationship, theme and component
function plotDcDropdown(chartId, cfDimension, cfGroup, panelId) {
    var chart = dc.selectMenu("#" + chartId, panelId);
    chart
            .dimension(cfDimension)
            .group(cfGroup)
            .controlsUseVisibility(true);
    chart.render();
}

//Used across Network, Open Text and Self Perception for number of responses as well as indices
function plotDcNumber(chartId, cfDimension, cfGroup, panelId) {
    var chart = dc.numberDisplay("#" + chartId, panelId);
    chart
//            .formatNumber(d3.format(".3s"))
            .valueAccessor(function (d) {
                plotVisNetwork("weSectionNetwork", ".weSection");
                plotOpenTextImage(d.key);
                return d.key;
            })
            .group(cfGroup);

//    setInterval(function () {
    chart.redraw();
//    }, 0);
}

function plotCytoNetwork(chartId) {
    var selectedRelationship = $('#dropdown_relationship').find(':selected').attr('value');
    var container = document.getElementById(chartId);

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
                    label: 'data(label)'
                }
            }, {
                selector: 'edge',
                style: {
//                    shape: 'hexagon',
//                    'background-color': 'red',
//                    label: 'data(weight)'
                }
            }]
    });

    for (var i = 0; i < nodes.length; i++) {
        cy.add({
            group: "nodes",
            data: {
                id: nodes[i].id,
                label: nodes[i].label,
                weight: nodes[i].weight,
                relId: nodes[i].relId
            }
        });
    }

    for (var i = 0; i < edges.length; i++) {
        cy.add({
            group: "edges",
            data: {
                id: edges[i].id,
                source: edges[i].from,
                target: edges[i].to,
                weight: edges[i].weight,
                relId: edges[i].relId
            }
        });
    }

//    cy.nodes().positions(function (node, i) {
//        return {
//            x: i * 100,
//            y: i * 50
//        };
//    });
//    cy.ready(
//        alert("ready")
//    );
}
function plotVisNetwork(chartId, panelId) {
    var selectedRelationship = $('#dropdown_relationship').find(':selected').attr('value');
    var container = document.getElementById(chartId);
    var ndata = nodes;

    ndata.forEach(function (d) {
        d.id = +d.id;
        d.label = d.firstName + " " + d.lastName;
        d.shape = 'ellipse';
    });
    var nDataSet = new vis.DataSet(ndata);

    var edata = edges;
    edata.forEach(function (d) {
        d.from = +d.from;
        d.to = +d.to;
    });

    var eDataSet = new vis.DataSet(edata);
    var items = eDataSet.get({
        filter: function (item) {
            return (selectedRelationship === "" ? item.relId !== null : item.relId === selectedRelationship);
        }
    });
    var networkData = {
        nodes: nDataSet,
        edges: items
    };
    var options = {};
    options.nodes = {
        color: '#C5CAE9'
    };
//    var network = new vis.Network(container, networkData, options);
}

function plotResponsiveCharts(chartId) {
    document.getElementById(chartId).style.display = 'none';
    document.getElementById(chartId).style.display = 'block';
    dc.renderAll();
}

function plotOpenTextImage(value) {
    if ((value >= 0) && (value <= 1)) {

        $(".openTextImage").removeClass("sad neutral happy happiest");
        $(".openTextImage").addClass("saddest");
    } else if ((value > 1) && (value <= 2)) {
        $(".openTextImage").removeClass("saddest neutral happy happiest");
        $(".openTextImage").addClass("sad");
    } else if ((value > 2) && (value <= 3)) {
        $(".openTextImage").removeClass("saddest sad happy happiest");
        $(".openTextImage").addClass("neutral");
    } else if ((value > 3) && (value <= 4)) {
        $(".openTextImage").removeClass("saddest sad neutral happiest");
        $(".openTextImage").addClass("happy");
    } else if ((value > 4) && (value <= 5)) {
        $(".openTextImage").removeClass("saddest sad neutral happy");
        $(".openTextImage").addClass("happiest");
    }
}

function plotTableExplanation(chartId, cfDimension, panelId) {
    var chart = dc.dataTable("#" + chartId, panelId);
    chart
            .width(200)
            .height(500)
            .dimension(cfDimension)
            .group(function (d) {
                return d.indexValue;
            })
            .showGroups(false)
            .columns([{
                    label: 'Explanation',
                    format: function (d) {
                        return d.explanation;
                    }
                },
                {
                    label: 'Action',
                    format: function (d) {
                        return d.action;
                    }
                }]);
//            .sortBy(function (d) {
//                return d.value;
//            });
//            .order(d3.descending)
    chart.render();
}

function plotTable(chartId, cfDimension, panelId) {
    var chart = dc.dataTable("#" + chartId, panelId);
    chart
            .width(200)
            .height(500)
            .dimension(cfDimension)
            .group(function (d) {
                return d.keyPeople;
            })
            .showGroups(false)
            .columns([{
                    label: 'Employee Name',
                    format: function (d) {
                        return d.keyPeople;
                    }
                }]);
//            .sortBy(function (d) {
//                return d.value;
//            });
//            .order(d3.descending)
    chart.render();
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
    plotDcDropdown("dropdown_theme", rel, relGroup, ".openText");

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
    plotDcDropdown("dropdown_component", rel, relGroup, ".meSection");

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

function plotStackedBar(chartId, distributionDim, stronglyAgreeGroup, agreeGroup, neutralGroup, disagreeGroup, stronglyDisagreeGroup) {
    var stackedBarChart = dc.barChart("#" + chartId);

    stackedBarChart
            .dimension(distributionDim)
            .group(stronglyAgreeGroup)
            .x(d3.scale.ordinal())
            .xUnits(dc.units.ordinal)
            .stack(agreeGroup)
//            .stack(function (d) {
//                return d3.round(
//                        (d.value / d3.sum(agreeGroup.all(), function (d) {
//                            return d.value;
//                        })) * 100, 1);
//            })
            .stack(neutralGroup)
            .stack(disagreeGroup)
            .stack(stronglyDisagreeGroup)
            ;

    stackedBarChart.render();
}

function sel_stack(i) {
    return function (d) {
        return d.key[i];
    };
}

function plotDcStackedBar(chartId, cfDimension, cfGroup, panelId) {
    var chart = dc.barChart("#" + chartId, panelId);
    chart
            .height(480)
            .x(d3.scale.ordinal().domain(cfDimension))
            .xUnits(dc.units.ordinal)
            .margins({left: 80, top: 20, right: 80, bottom: 20})
            .brushOn(false)
            .elasticY(true)
            .clipPadding(20)
//              .title(function(d) {
//                  return d.key + '[' + this.layer + ']: ' + d.value[this.layer];
//              })
            .dimension(cfDimension)
            .group(cfGroup, "1", sel_stack('1'))
            .renderLabel(true);

    chart.legend(
            dc.legend()
            .x($('#' + chartId).width() + 18)
            .y(0)
            .itemHeight(13)
            .gap(5)
//                .horizontal(true)
//                .legendWidth(250)
            .autoItemWidth(true));

    dc.override(chart, 'legendables', function () {
        var items = chart._legendables();
        return items.reverse();
    });

    for (var i = 2; i < 6; ++i)
        chart.stack(cfDimension, '' + i, sel_stack(i));
    chart.render();

//    plotResponsiveCharts(chartId);
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