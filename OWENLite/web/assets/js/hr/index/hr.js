/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var metricList;
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

    //Function call with value to change smiley of sentiment 
    plotOpenTextImage(2);

    go();
    plotRelationship();

    //WORDCLOUD
    var data = "data.json";
    d3.json(data, function (key) {
//        console.log(key);
        var ndx = crossfilter(key);
        plotWordCloud(ndx);
    });

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


});

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
    
    var responseDim = cf.dimension(function (d){
        return d.responseCount;
    });
        plotDcNumber("weSectionResponses", responseDim, responseDim.group(), ".weSection");

    

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
                return d.key;
            })
            .group(cfGroup);

    setInterval(function () {
        chart.redraw();
    }, 0);
}

//Used in Self Perception to plot distribution of responses
function plotDcBar(chartId, cfDimension, cfGroup, panelId) {
    var chart = dc.barChart("#" + chartId, panelId);
    chart
            .margins({top: 0, bottom: 30, left: 50, right: 20})
            .dimension(cfDimension)
            .group(cfGroup)
//            .yAxisLabel("Count")
            .elasticY(true)
//            .showYAxis(false)
            .valueAccessor(function (p) {
                return p.value.avg;
            })
            .x(d3.scale.ordinal().domain(cfDimension)) // Need the empty val to offset the first value
            .xUnits(dc.units.ordinal) // Tell Dc.js that we're using an ordinal x axis
            .ordinalColors(['#7986CB'])
//            .label(function (d) {
//                return d.key + " = " + d.value;
//            })
            .centerBar(false);

    chart.on("renderlet", function (chart) {
        var gLabels = chart.select(".labels");
        if (gLabels.empty()) {
            gLabels = chart.select(".chart-body").append('g').classed('labels', true);
        }

        var gLabelsData = gLabels.selectAll("text").data(chart.selectAll(".bar")[0]);
        gLabelsData.exit().remove(); //Remove unused elements

        gLabelsData.enter().append("text"); //Add new elements

        gLabelsData
                .attr('text-anchor', 'middle')
                .attr('fill', 'white')
                .text(function (d) {
                    return d3.select(d).data()[0].data.value.avg;
                })
                .attr('x', function (d) {
                    return +d.getAttribute('x') + (d.getAttribute('width') / 2);
                })
                .attr('y', function (d) {
                    return +d.getAttribute('y') + 15;
                })
                .attr('style', function (d) {
                    if (+d.getAttribute('height') < 18)
                        return "display:none";
                });
    });

    plotResponsiveCharts(chartId);
}

function plotVisNetwork(chartId, panelId) {
    var selectedM1 = $('#dropdown_function').find(':selected').attr('value');
    var selectedM2 = $('#dropdown_position').find(':selected').attr('value');
    var selectedM3 = $('#dropdown_location').find(':selected').attr('value');

//    var relationshipType = $('input[name=options]:checked').val();

//    var container = document.getElementById('engagement_q5_chart6');
    var ndata = nodes.data;

    ndata.forEach(function (d) {
        d.id = +d.id;
        d.value = +d.value;
    });
    var nDataSet = new vis.DataSet(ndata);
    var items = nDataSet.get({
        filter: function (item) {
//            item.m4 = d3.time.format.utc("%d/%m/%y").parse(item.m4);
//            if (date.length > 1) {
//                date[0] = d3.time.format.utc("%d/%m/%y").parse(date[0].trim());
//                date[1] = d3.time.format.utc("%d/%m/%y").parse(date[1].trim());
//            }

            return ((selectedM1 === "" ? item.m1 !== null : item.m1 === selectedM1)
                    && (selectedM2 === "" ? item.m2 !== null : item.m2 === selectedM2)
                    && (selectedM3 === "" ? item.m3 !== null : item.m3 === selectedM3)
                    && (item.type === type)
                    && (date.length <= 1
                            ? item.m4 !== null
                            : (d3.time.format.utc("%d/%m/%y").parse(item.m4) > d3.time.format.utc("%d/%m/%y").parse(date[0].trim())
                                    && d3.time.format.utc("%d/%m/%y").parse(item.m4) < d3.time.format.utc("%d/%m/%Y").parse(date[1].trim()))));
        }
    });
    var edata = edges.data;
    edata.forEach(function (d) {
        d.from = +d.from;
        d.to = +d.to;
//        d.value = +d.value;
    });
    var eDataSet = new vis.DataSet(edata);
    var networkData = {
        nodes: items,
        edges: eDataSet
    };
    var options = {};
    options.nodes = {
        color: '#C5CAE9'
    };




    var network = new vis.Network(container, networkData, options);
}

function plotResponsiveCharts(chartId) {
    document.getElementById(chartId).style.display = 'none';
    document.getElementById(chartId).style.display = 'block';
    dc.renderAll();
}

function plotOpenTextImage(value) {
    if ((value >= 0) && (value <= 1)) {
        $(".openTextImage").addClass("saddest");
    } else if ((value > 1) && (value <= 2)) {
        $(".openTextImage").addClass("sad");
    } else if ((value > 2) && (value <= 3)) {
        $(".openTextImage").addClass("neutral");
    } else if ((value > 3) && (value <= 4)) {
        $(".openTextImage").addClass("happy");
    } else if ((value > 4) && (value <= 5)) {
        $(".openTextImage").addClass("happiest");
    }
}

function plotWordCloud(ndx) {
    var wordcloudChart = dc.wordcloudChart('.openTextWordCloud');

    var wordDim = ndx.dimension(function (d) {
//        console.log(d);
        return d.key;
    });

    var wordGroup = wordDim.group().reduceSum(function (d) {
        return d.value;
    });

    wordcloudChart.options({
        height: 282,
        width: 573,
        minY: -10,
        minX: -50,
//        relativeSize: 20,
        dimension: wordDim,
        group: wordGroup,
        valueAccessor: function (d) {
            return d.value;
        },
        title: function (d) {
            return [d.key, 'Word Count: ' + d.value].join('\n');
        }
    });

    wordcloudChart.render();
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
            metricList = JSON.parse(response.metricList);
            sentimentList = JSON.parse(response.sentimentList);
            selfPerceptionList = JSON.parse(response.selfPerceptionList);
            sentimentScore = JSON.parse(response.sentimentScore);
            indexValue = JSON.parse(response.indexValue);
            keyPeople = JSON.parse(response.keyPeople);
            selfPerception = JSON.parse(response.selfPerception);
            wordCloud = JSON.parse(response.wordCloud);
            console.log("fetched data successfully");
        },
        error: function (resp, err) {
            console.log("unable to fetch data error messsage : " + err);
        }
    });
}