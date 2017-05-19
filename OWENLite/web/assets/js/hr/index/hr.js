/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//$(window).on("load", function () {
$(document).ready(function () {
    $('.filterPanel').Stickyfill();

    //Function call with value to change smiley of sentiment 
    plotOpenTextImage(2);

    //WORDCLOUD
    var data = "data.json";
    d3.json(data, function (key) {
        console.log(key);
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
            .formatNumber(d3.format(".3s"))
            .valueAccessor(function (d) {
                return d.value.avg;
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
        console.log(d);
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