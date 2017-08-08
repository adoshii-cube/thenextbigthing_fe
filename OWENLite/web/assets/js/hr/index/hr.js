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
var cy;
var arrNodes = [];
var arrEdges = [];
$(document).ready(function () {
    //clear any selected option from the dropdown
    $("#dropdown_function").parent().find(".mdl-selectfield__list-option-box li.is-selected").removeClass("is-selected");
    //manually select the first option so that it is not ALL for both HTML select and MDL select
    $("#dropdown_function").parent().find('.mdl-selectfield__list-option-box li').each(function () {
        if ($(this).attr("data-value") === "1") {
            $(this).addClass("is-selected");
        }
    });
    $("#dropdown_function option[value='1']").attr('selected', 'selected');
    // force the text to read the text of value 1
    var selectedOption = $("#dropdown_function").parent().find(".mdl-selectfield__list-option-box li.is-selected").text();
    $("#dropdown_function").parent().find(".mdl-selectfield__box-value").text(selectedOption);

    var slider = $("#slider").slideReveal({
        trigger: $("#trigger2"),
        position: "left",
//        width: "18%",
        push: true,
        top: 64,
        show: function (slider, trigger) {
            $("#trigger2 i").text("keyboard_arrow_left");
            $("main").css("max-width", "" + $(window).width() - $("#slider").width() + "px");
        },
        hide: function (slider, trigger) {
            $("#trigger2 i").text("keyboard_arrow_right");
            $("main").css("max-width", "100%");
        },
        shown: function () {
            resizeHighCharts();
            if ($(".mdl-tabs__panel.is-active").attr("id") === "panelRelationship") {
//                $("#relationshipNetwork").css("width", window.innerWidth - $("#legendColorByContainer").width()  - $("#slider").width() - 128);
            }
        },
        hidden: function () {
            resizeHighCharts();
            if ($(".mdl-tabs__panel.is-active").attr("id") === "panelRelationship") {
//                $("#relationshipNetwork").css("width", window.innerWidth - $("#legendColorByContainer").width() - 128);
            }
        }
    });
    fetchData(true);
    $('#resizeNetwork').magnificPopup({
        items: {
            src: '#networkChartLegendColorContainer',
            type: 'inline'
        },
        showCloseBtn: false,
        midClick: true, // allow opening popup on middle mouse click. Always set it to true if you don't provide alternative source.
        callbacks: {
            open: function () {
                $("#relationshipNetwork").css("height", window.innerHeight - 32);
                $("#legendContainer").css("max-height", window.innerHeight - $("#colorByContainer").height());
                $(".hiddenButton").css("display", "flex");
                cy.resize();
            },
            close: function () {
                $("#relationshipNetwork").css("height", "300px");
                $("#legendContainer").css("max-height", "220px");
                $(".hiddenButton").css("display", "none");
                cy.resize();
            }
        }
    });

    $("#resizeNetworkExit").on("click", function () {
        $.magnificPopup.close();
    });

    $("#dropdown_relationship").on("change", function () {
        setTimeout(function () {
            plotRelationshipCharts(false);
            var dropdownSelected = $("#dropdown_relationship").parent().find(".mdl-selectfield__list-option-box li.is-selected").text();
            var indexValueTitle = $("#relationshipIndex").parent().find(".mdl-card__title");
            var keyPeopleTitle = $("#relationshipListOfPeople").parent().parent().find(".mdl-card__title");
            if (dropdownSelected === "Work") {
                indexValueTitle.text("Collaboration Index");
                keyPeopleTitle.text("List of Key Experts");
            } else if (dropdownSelected === "Mentorship") {
                indexValueTitle.text("Mentorship Index");
                keyPeopleTitle.text("List of Mentors");
            } else if (dropdownSelected === "Innovation") {
                indexValueTitle.text("Innovation Index");
                keyPeopleTitle.text("List of Innovators");
            } else if (dropdownSelected === "Informal") {
                indexValueTitle.text("Social Cohesion Index");
                keyPeopleTitle.text("List of Influencers");
            }
        }, 50);
    });
    $("#dropdown_sentiment").on("change", function () {
        setTimeout(function () {
            plotSentimentCharts(false);
        }, 50);
    });
    $("#dropdown_component").on("change", function () {
        setTimeout(function () {
            plotComponentCharts(false);
        }, 50);
    });
    $("#dropdown_relationship_color").on("change", function () {
        setTimeout(function () {
            plotLegend(false);
        }, 50);
    });
    $("#goFilterDataButton").on("click", function () {
        setTimeout(function () {
            fetchData(false);
        }, 10);
    });
    $(".mdl-tabs__tab-bar").on("click", function () {
        var selectedTab = $(".mdl-tabs__tab-bar").find(".mdl-tabs__tab.is-active").attr("href");
        if (selectedTab === "#panelRelationship") {
            cy.resize();
        }
        resizeHighCharts();
    });

    $(".downloadAsImage").on("click", function () {
        $(".downloadAsImage").prop("disabled", true);
        $(".mdl-tooltip").removeClass("is-active");
        var element;
        var chartTitle;
        if (($(this).attr("id") === "downloadNetwork") || ($(this).attr("id") === "downloadNetworkFromPopup")) {
            element = $("#networkChartLegendColorContainer");
            chartTitle = "OWENLite-Network";
        }
        downloadAsImage(element, chartTitle);
        setTimeout(function () {
            $(".downloadAsImage").prop("disabled", false);
        }, 5000);
    });

    $(".downloadHcAsImage").on("click", function () {
        var element;
        var chartTitle;
        var downloadButtonClicked = $(this);
        downloadButtonClicked.prop("disabled", true);
        $(".mdl-tooltip").removeClass("is-active");
        if ($(this).attr("id") === "downloadrelationshipIndex") {
            element = $("#relationshipIndex");
            chartTitle = "OWENLite-Relationship-Index";
        } else if ($(this).attr("id") === "downloadSentimentGauge") {
            element = $("#sentimentGauge");
            chartTitle = "OWENLite-Sentiment-Gauge";
        } else if ($(this).attr("id") === "downloadSentimentDistribution") {
            element = $("#sentimentDistribution");
            chartTitle = "OWENLite-Sentiment-Distribution";
        } else if ($(this).attr("id") === "downloadComponentDistribution") {
            element = $("#componentDistribution");
            chartTitle = "OWENLite-SelfPerception-Distribution";
        }

        var svgElements = $(element).find('svg');

        //replace all svgs with a temp canvas
        svgElements.each(function () {
            var canvas, xml;
            // canvg doesn't cope very well with em font sizes so find the calculated size in pixels and replace it in the element.
            $.each($(this).find('[style*=em]'), function (index, el) {
                $(this).css('font-size', getStyle(el, 'font-size'));
            });

            canvas = document.createElement("canvas");
            canvas.className = "screenShotTempCanvas";
            //convert SVG into a XML string
            xml = (new XMLSerializer()).serializeToString(this);

            // Removing the name space as IE throws an error
            xml = xml.replace(/xmlns=\"http:\/\/www\.w3\.org\/2000\/svg\"/, '');

            //draw the SVG onto a canvas
            canvg(canvas, xml);
            $(canvas).insertAfter(this);
            //hide the SVG element
            $(this).attr('class', 'tempHide');
            $(this).hide();
        });

        downloadAsImage(element, chartTitle);

        $(element).find('.screenShotTempCanvas').remove();
        $(element).find('.tempHide').show().removeClass('tempHide');

        setTimeout(function () {
            downloadButtonClicked.prop("disabled", false);
        }, 5000);
    });

    $("#slider").css("display", "block");
    slider.slideReveal("show");

});

function fetchData(isFirstTime) {
    nodes = undefined;
    edges = undefined;
    sentimentScore = undefined;
    indexValue = undefined;
    keyPeople = undefined;
    selfPerception = undefined;
    sentimentDistribution = undefined;
    wordCloud = undefined;
    var relationshipTab;
    var sentimentTab;
    var componentTab;

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
            relationshipTab = JSON.parse(response.relationshipTab);
            sentimentTab = JSON.parse(response.sentimentTab);
            componentTab = JSON.parse(response.componentTab);
//            if (!relationshipTab && !sentimentTab && !componentTab) {
//                if (isFirstTime) {
//                    // show dashboard empty state message
//                    $(".pageLoaderContainer").css("display", "none");
//                    $(".dashboard").css("display", "none");
//                    $(".emptyDashboard").css("display", "block");
//                    $("#slider").css("display", "none");
//                }
//            } else {
//                $(".pageLoaderContainer").css("display", "none");
//                $(".dashboard").css("display", "flex");
//                $(".emptyDashboard").css("display", "none");
//                $("#slider").css("display", "block");
//            }

            var relationship = function () {
                var defer = $.Deferred();

                console.log('a() called');
                if (relationshipTab) {
                    $("#relationshipPanel").css("display", "flex");
                    $("#relationshipPanelEmptyState").css("display", "none");
                    nodes = JSON.parse(response.nodes);
                    edges = JSON.parse(response.edges);
                    indexValue = JSON.parse(response.indexValue);
                    keyPeople = JSON.parse(response.keyPeople);
                    plotRelationshipCharts(isFirstTime);
                    // FETCH API CODE
//                var empId = $('#empId').val();
//                var comId = $('#comId').val();
//                var jsonDataFile = "../hr/jsonDataFiles/networkData_" + comId + "_" + empId + ".json";
//                var request = new Request(jsonDataFile, {
//                    method: 'POST',
//                    mode: 'no-cors',
//                    redirect: 'follow',
//                    headers: new Headers({
////                        'Content-Type': 'text/plain',
//                        'Accept': 'application/json',
//                        'Content-Type': 'text/json',
//                        'cache-control': 'no-cache'
//                    })
//                });
//
//
//                fetch(request)
//                        .then(function (res) {
//                            return res.json();
//                        })
//                        .then(function (data) {
//                            plotRelationshipCharts(isFirstTime, data);
//                        });
                } else {
                    $("#relationshipPanel").css("display", "none");
                    $("#relationshipPanelEmptyState").css("display", "flex");
                    $('body').find("#panelRelationshipLabel").removeClass("mdl-tabs-panel-disabled");
                }


                setTimeout(function () {
                    defer.resolve(); // When this fires, the code in a().then(/..../); is executed.
                }, 5000);

                return defer;
            };

            var sentiment = function () {
                var defer = $.Deferred();

                console.log('b() called');
                if (sentimentTab) {
                    $("#sentimentPanel").css("display", "flex");
                    $("#sentimentPanelEmptyState").css("display", "none");
                    sentimentScore = JSON.parse(response.sentimentScore);
                    sentimentDistribution = JSON.parse(response.sentimentDistribution);
                    wordCloud = JSON.parse(response.wordCloud);
                    plotSentimentCharts(isFirstTime);
                } else {
                    $("#sentimentPanel").css("display", "none");
                    $("#sentimentPanelEmptyState").css("display", "flex");
                    $('body').find("#panelSentimentLabel").removeClass("mdl-tabs-panel-disabled");
                }

                setTimeout(function () {
                    defer.resolve();
                }, 5000);

                return defer;
            };

            var component = function () {
                var defer = $.Deferred();

                console.log('c() called');
                if (componentTab) {
                    $("#componentPanel").css("display", "flex");
                    $("#componentPanelEmptyState").css("display", "none");
                    selfPerception = JSON.parse(response.selfPerception);
                    plotComponentCharts(isFirstTime);
                } else {
                    $("#componentPanel").css("display", "none");
                    $("#componentPanelEmptyState").css("display", "flex");
                    $('body').find("#panelComponentLabel").removeClass("mdl-tabs-panel-disabled");
                }

                setTimeout(function () {
                    defer.resolve();
                }, 5000);

                return defer;
            };

            if (isFirstTime) {
                relationship().then(sentiment).then(component);
            } else {
                $(".mdl-tabs__tab-bar").find(".mdl-tabs__tab:not(.is-active)").each(function () {
                    $(this).addClass("mdl-tabs-panel-disabled");
                });
                var activeTab = $(".mdl-tabs__tab-bar").find(".is-active").attr("id").replace("panel", "").replace("Label", "").toLowerCase();
                if (activeTab === "relationship") {
                    relationship().then(sentiment).then(component);
                } else if (activeTab === "sentiment") {
                    sentiment().then(relationship).then(component);
                } else {
                    component().then(sentiment).then(relationship);
                }
            }
        },
        error: function (resp, err) {
            console.log("unable to fetch data error messsage : " + err);
        },
        complete: function () {
            if (!relationshipTab && !sentimentTab && !componentTab) {
                if (isFirstTime) {
                    // show dashboard empty state message
                    $(".pageLoaderContainer").css("display", "none");
                    $(".dashboard").css("display", "none");
                    $(".emptyDashboard").css("display", "block");
                    $("#slider").css("display", "none");
                }
            } else {
                $(".pageLoaderContainer").css("display", "none");
                $(".dashboard").css("display", "flex");
                $(".emptyDashboard").css("display", "none");
//                $("#slider").css("display", "block");
            }
        }
    });
}

function fetchOptionValue(isFirstTime, dropdownName) {
    var optionValue = "";
    if (isFirstTime) {
        if (dropdownName)
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
    if (!(typeof (componentHandler) === 'undefined')) {
        componentHandler.upgradeAllRegistered();
    }
    var optionValue = fetchOptionValue(isFirstTime, "dropdown_relationship");
    if (indexValue[optionValue] === undefined) {
        $("#relationshipChartsEmptyState").css("display", "flex");
        $("#relationshipCharts").css("display", "none");
    } else {
        $("#relationshipChartsEmptyState").css("display", "none");
        $("#relationshipCharts").css("display", "flex");

        $("#relationshipChartsLoader").css("visibility", "visible");
//        setTimeout(function () {

        // response count
        $("#relationshipResponses").empty();
        $("#relationshipResponses").append(indexValue[optionValue].responseCount);
        // network diagram
//        if ($(".mdl-tabs__tab-bar").find(".mdl-tabs__tab.is-active").attr("href") === "#panelRelationship") {
//        plotCytoNetwork("relationshipNetwork", optionValue, colorByValue);
        plotLegend(isFirstTime);

//        }
        // index value
//        $("#relationshipIndex").empty();
//        $("#relationshipIndex").append(indexValue[optionValue].indexValue);
        plotRelationshipGauge("relationshipIndex", optionValue, indexValue[optionValue].indexValue);
        // key people
        plotHCTable(keyPeople[optionValue]);
        // action
        $("#relationshipAction").empty();
        $("#relationshipAction").append(indexValue[optionValue].action);
        // explanation
        $("#relationshipExplanation").empty();
        $("#relationshipExplanation").append(indexValue[optionValue].explanation);

        $("#relationshipChartsLoader").css("visibility", "hidden");


//        }, 500);
    }
    $('body').find("#panelRelationshipLabel").removeClass("mdl-tabs-panel-disabled");

}

function plotCytoNetwork(chartId, selectedRelationship, colorByValue) {
    var container = document.getElementById(chartId);
    $.when().then(function () {
        arrNodes = [];
        $.each(nodes, function () {
            if (colorByValue === 1) {
                this.color = this.fColor;
            } else if (colorByValue === 2) {
                this.color = this.pColor;
            } else if (colorByValue === 3) {
                this.color = this.lColor;
            }
            arrNodes.push({
                group: "nodes",
                data: this
            });
        });

        arrEdges = [];
        $.each(edges, function () {
            if (this.relId === selectedRelationship) {
                arrEdges.push({
                    group: "edges",
                    data: this
                });

            }
        });

//Set minZoomValue ,maxZoomValue
        var minZoomValue, maxZoomValue;
        if (arrNodes.length < 50) {
            minZoomValue = 0.5;
            maxZoomValue = 2;
        } else if (arrNodes.length < 100 && arrNodes.length > 50) {
            minZoomValue = 0.3;
            maxZoomValue = 2;
        } else if (arrNodes.length > 500) {
            minZoomValue = 1e-1;
            maxZoomValue = 2;
        }

        cy = cytoscape({
            container: container,
            minZoom: minZoomValue,
            maxZoom: maxZoomValue,
            zoomingEnabled: true,
            userZoomingEnabled: true,
            panningEnabled: true,
            userPanningEnabled: true,
            hideEdgesOnViewport: true,
            hideLabelsOnViewport: true,
            layout: {
                name: 'cose'
            },
//            render: function () {
//                alert("render");
//            },
//        animate: true,
//        // The layout animates only after this many milliseconds
//        // (prevents flashing on fast runs)
//        animationThreshold: 250,
//        // Number of iterations between consecutive screen positions update
//        // (0 -> only updated on the end)
//        refresh: 20,
//        // Whether to fit the network view after when done
////        fit: true,
//        // Padding on fit
//        padding: 30,
            style: [
                {
                    selector: 'node',
                    style: {
//                    shape: 'hexagon',
                        'background-color': 'data(color)',
                        content: 'data(firstName)',
                        height: function (ele) {
//                        console.log(ele._private.data.firstName + " ::: " + ele.indegree());
                            return (ele.indegree() + 1) * 2;
                        },
                        width: function (ele) {
                            return (ele.indegree() + 1) * 2;
                        }
                    }
                }, {
                    selector: 'edge',
                    style: {
//                    'background-color': 'red',
                        'line-color': '#bdbdbd',
                        'curve-style': 'bezier',
                        'target-arrow-shape': 'triangle',
                        'target-arrow-color': '#bdbdbd',
                        'source-arrow-shape': 'circle',
                        'source-arrow-color': '#bdbdbd',
                        'opacity': 0.666,
                        'width': 'data(weight)'
                    }
                }],
            elements: {
                nodes: arrNodes,
                edges: arrEdges
            }
        });
//
//        cy.on('layoutstart', function (e) {
////            alert("layout start");
//            // Notice the layoutstart event with the layout name.
////            console.log('layoutstart', e.cyTarget.options.name);
//
//        });
//
//        cy.on('layoutstop', function (e) {
//
//            // Notice the layoutstop event with the layout name.
//            
////            console.log('layoutstop', e.cyTarget.options.name);
//
//        });
        cy.elements("node").qtip({
            content: function () {
//            return 'Example qTip on ele ' + this.id();
//                return this.data().lastName;
                var phrase = " people are ";
                if (this.indegree() === 1) {
                    phrase = " person is ";
                }
                var tooltip = this.indegree() + phrase + " connected to " + (this.data().firstName).bold();
                return tooltip;
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

//        cy.layout(options);
//        layout.pon('layoutstop').then(function (event) {
//            console.log('layoutstop promise fulfilled');
//        });
//        layout.on('layoutstop', function () {
//        $("#relationshipNetworkLoaderContainer").css("display", "none");
//        $("#relationshipNetwork").css("display", "flex");
//        });

        cy.resize();
    });
}

function plotLegend(isFirstTime) {
//    $("#relationshipNetwork").css("display", "none");
//    $("#relationshipNetworkLoaderContainer").css("display", "flex");
    var colorByValue = fetchOptionValue(isFirstTime, "dropdown_relationship_color");
    var functionValues = JSON.parse($('#functionValues').val());
    var positionValues = JSON.parse($('#positionValues').val());
    var locationValues = JSON.parse($('#locationValues').val());

    $(".legend").empty();

    if (colorByValue === 1) {
        var count = 1;
        for (var key in functionValues) {
            $(".legend").append('<li class="nodes"><span class="nodeColor' + count + '"></span>' + functionValues[key] + '</li>');
            count++;
        }
    } else if (colorByValue === 2) {
        var count = 1;
        for (var key in positionValues) {
            $(".legend").append('<li class="nodes"><span class="nodeColor' + count + '"></span>' + positionValues[key] + '</li>');
            count++;
        }
    }
    if (colorByValue === 3) {
        var count = 1;
        for (var key in locationValues) {
            $(".legend").append('<li class="nodes"><span class="nodeColor' + count + '"></span>' + locationValues[key] + '</li>');
            count++;
        }
    }

    var optionValue = fetchOptionValue(false, "dropdown_relationship");
    plotCytoNetwork("relationshipNetwork", optionValue, colorByValue);
//    $("#relationshipNetworkLoaderContainer").css("display", "none");
//    $("#relationshipNetwork").css("display", "flex");
}

function plotRelationshipGauge(chartId, dropdownOptionValue, teamScore) {
    var orgScore;

    if (dropdownOptionValue === 7) {
        orgScore = 3.3;
    } else if (dropdownOptionValue === 8) {
        orgScore = 3.3;
    } else if (dropdownOptionValue === 9) {
        orgScore = 3.0;
    } else if (dropdownOptionValue === 10) {
        orgScore = 3.6;
    }

    Highcharts.chart(chartId, {

        chart: {
            height: null,
            width: null,
            type: 'solidgauge',
            className: 'resizeCharts',
            spacingTop: 0,
            spacingLeft: 0,
            spacingRight: 0,
            spacingBottom: 0,
            margin: [0, 0, 0, 0],
            style: {
                fontFamily: 'Roboto'
            }
        },
        title: {
            text: null
        },
        tooltip: {
            enabled: false,
//            borderWidth: 0,
            backgroundColor: 'none',
            shadow: false
//            style: {
//                fontSize: '16px'
//            },
//            pointFormat: '{series.name}<br><span style="font-size:2em; color: {point.color}; font-weight: bold">{point.y}</span>',
//            positioner: function (labelWidth, labelHeight) {
//                return {
//                    x: 230 - labelWidth / 2,
//                    y: 90
//                };
//            }
        },
        pane: {
            startAngle: 0,
            endAngle: 360,
            background: [{// Track for Team
                    outerRadius: '112%',
                    innerRadius: '88%',
                    backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.3).get(),
                    borderWidth: 0
                }, {// Track for Org
                    outerRadius: '87%',
                    innerRadius: '63%',
                    backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[1]).setOpacity(0.3).get(),
                    borderWidth: 0
                }]
        },
        yAxis: {
            min: 0,
            max: 5,
            lineWidth: 0,
            tickPositions: []
        },
        plotOptions: {
            solidgauge: {
                animation: false,
                borderWidth: '26px',
                dataLabels: {
                    enabled: true,
//                    color: 'rgba(255,255,255,.54)',
                    borderWidth: 0,
//                    shape: 'callout',
//                    backgroundColor: 'rgba(0, 0, 0, 0.75)',
                    style: {
//                        color: Highcharts.Color(Highcharts.getOptions().colors[0]).get(),
                        fontSize: '14px',
                        textOutline: false,
                        textShadow: false
                    },
//                    y: -12,
                    allowOverlap: true,
                    zIndex: 100,
                    formatter: function () {
                        return this.series.name + ": " + this.y;
                    }
                },
                linecap: 'round',
                stickyTracking: false
            }
        },
        series: [{
                name: 'Org',
                borderColor: Highcharts.getOptions().colors[0],
                data: [{
                        color: Highcharts.getOptions().colors[0],
                        radius: '100%',
                        innerRadius: '100%',
                        y: orgScore
                    }],
                marker: {enabled: false},
                showInLegend: false,
                dataLabels: {
                    y: -22,
                    style: {
                        color: Highcharts.Color(Highcharts.getOptions().colors[0]).get()
                    }
                }
            },
            {
                name: 'Team',
                borderColor: Highcharts.getOptions().colors[1],
                data: [{
                        color: Highcharts.getOptions().colors[1],
                        radius: '75%',
                        innerRadius: '75%',
                        y: teamScore
                    }],
                marker: {enabled: false},
                showInLegend: false,
                dataLabels: {
                    y: -8,
                    style: {
                        color: Highcharts.Color(Highcharts.getOptions().colors[1]).get()
                    }
                }
                /*dataLabels: {
                 x: -85,
                 y: 50,
                 }*/
            }],
        legend: {
            labelFormatter: function () {
                return '<span style="text-weight:bold;color:' + this.userOptions.color + '">' + this.name + '</span>';
            },
            symbolWidth: 0
        },
        credits: {
            enabled: false
        },
        navigation: {
            buttonOptions: {
                enabled: false
            }
        },
        exporting: {
            chartOptions: {
                title: {
                    text: null
                }
            }
//            buttons: {
//                contextButton: {
//                    menuItems: null,
//                    symbol: 'url(../assets/images/cancel.png)',
//                    _titleKey: 'popUpBtnTitle',
//                    onclick: function () {
//                        this.exportChart();
//                    }
//                }
//            }
        }
    });
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
    if (sentimentScore[optionValue] === undefined) {
//show empty state message
        $("#sentimentChartsEmptyState").css("display", "flex");
        $("#sentimentCharts").css("display", "none");
    } else {
        $("#sentimentChartsEmptyState").css("display", "none");
        $("#sentimentCharts").css("display", "flex");

        $("#sentimentChartsLoader").css("visibility", "visible");

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

        $("#sentimentChartsLoader").css("visibility", "hidden");
    }
    $('body').find("#panelSentimentLabel").removeClass("mdl-tabs-panel-disabled");
}

function plotHCGauge(dataValue) {
    var gaugeOptions = {
        chart: {
            animation: false,
            type: 'solidgauge',
            className: 'resizeCharts',
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
//                animation: false,
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
        navigation: {
            buttonOptions: {
                enabled: false
            }
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
            }],
        exporting: {
            chartOptions: {
                title: {
                    text: null
                }
            }
        }

    }));
}

function plotStackedSentiment(containerId, seriesData) {
//    Highcharts.chart('HCStacked_Bar', {
    Highcharts.chart(containerId, {
        chart: {
            animation: false,
            type: 'bar',
            className: 'resizeCharts'
//            height: 130,
//            width: 300
        },
//        colors: ['#DD2C00', '#FFD600', '#64DD17'],
        credits: {
            enabled: false
        },
        navigation: {
            buttonOptions: {
                enabled: false
            }
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
                animation: false,
                stacking: 'percent',
                colorByPoint: true,
                dataLabels: {
                    enabled: false,
                    crop: false,
                    overflow: 'none'
                }
            }
        },
        series: seriesData,
        exporting: {
            chartOptions: {
                chart: {
                    events: {
                        load: function () {
                            title: null,
//                                    Highcharts.each(this.series, function (series) {
//                                        series.update({
//                                            dataLabels: {
//                                                enabled: true,
//                                                style: {
//                                                    color: '#ff9800',
//                                                    fontSize: '14px'
//                                                }
//                                            }
////                                        }, false);
//                                    });
                                    this.redraw(false);
                        }
                    }
                }
            }
        }
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
    WordCloud(($("#" + chartId)[0]), {
        list: list,
        fontFamily: 'Roboto',
        backgroundColor: '#ffffff',
        rotateRatio: 0,
//        shape: 'pentagon',
//        gridSize: 5,
//        minSize: 1,
        weightFactor: 1,
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
//    $("#" + chartId).on("wordcloudstop", function () {
//        alert("wordcloud drawn");
//        zoomOnWordCloud();
//    });
}

function plotComponentCharts(isFirstTime) {
    var optionValue = fetchOptionValue(isFirstTime, "dropdown_component");
    if (selfPerception[optionValue] === undefined) {
        $("#componentChartsEmptyState").css("display", "flex");
        $("#componentCharts").css("display", "none");
    } else {
        $("#componentChartsEmptyState").css("display", "none");
        $("#componentCharts").css("display", "flex");

        $("#componentChartsLoader").css("visibility", "visible");

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


        $("#componentChartsLoader").css("visibility", "hidden");
    }
    $('body').find("#panelComponentLabel").removeClass("mdl-tabs-panel-disabled");

}

function plotStackedComponent(containerId, seriesData) {
//    Highcharts.chart('HCStacked_Bar', {
    Highcharts.chart(containerId, {
        animation: false,
        chart: {
            type: 'bar',
            className: 'resizeCharts'
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
        title: {
            text: null
        },
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
//                animation: false,
                stacking: 'percent',
//                colorByPoint: true,
                dataLabels: {
                    enabled: false,
                    crop: false,
                    overflow: 'none'
                }
            }
        },
        series: seriesData,
        navigation: {
            buttonOptions: {
                enabled: false
            }
        },
        exporting: {
            chartOptions: {
                chart: {
                    events: {
                        load: function () {
                            title: null,
//                                    Highcharts.each(this.series, function (series) {
//                                        series.update({
//                                            dataLabels: {
//                                                enabled: true,
//                                                style: {
//                                                    color: '#ff9800',
//                                                    fontSize: '14px'
//                                                }
//                                            }
////                                        }, false);
//                                    });
                                    this.redraw(false);
                        }
                    }
                }
            }
        }
    });
}

function resizeHighCharts() {
    var chart1 = "";
    var chart2 = "";
    if ($(".mdl-tabs__panel.is-active").attr("id") === "panelRelationship") {
        chart1 = $("#relationshipIndex").highcharts();
        chart1.setSize(undefined, undefined, false);
    } else if ($(".mdl-tabs__panel.is-active").attr("id") === "panelSentiment") {
        chart1 = $("#sentimentGauge").highcharts();
        chart1.setSize(undefined, undefined, false);
        chart2 = $("#sentimentDistribution").highcharts();
        chart2.setSize(undefined, undefined, false);
    } else if ($(".mdl-tabs__panel.is-active").attr("id") === "panelComponent") {
        chart1 = $("#componentDistribution").highcharts();
        chart1.setSize(undefined, undefined, false);
    }
//    $(Highcharts.charts).each(function (i, chart) {
////        var height = chart.renderTo.clientHeight;
////        var width = chart.renderTo.clientWidth;
//        chart.setSize(undefined, undefined, false);
//        chart.reflow();
//        chart.redraw();
//    });
}

function downloadAsImage(element, chartTitle) {
    html2canvas(element).then(function (canvas) {
        var imgPathUrl = canvas.toDataURL();
        //create temporary anchor tag in which url will be stored and clicked to trigger download
        var link = document.createElement('a');
        link.setAttribute("href", imgPathUrl);
        link.setAttribute("download", chartTitle + '.png');
//            window.open(imgPathUrl);
        link.click();
    });
}

function zoomOnWordCloud() {

// Settings
    var contentWidth = 380;
    var contentHeight = 250;

    var content = document.getElementById('sentimentWordCloud');
    var context = content.getContext('2d');
//var tiling = new Tiling;


// Canvas renderer
    var render = function (left, top, zoom) {

        // Sync current dimensions with canvas
        content.width = clientWidth;
        content.height = clientHeight;

        // Full clearing
        context.clearRect(0, 0, clientWidth, clientHeight);

    };

// Intialize layout
    var container = document.getElementById("sentimentWordCloudContainer");
//var content = document.getElementById("sentimentWordCloud");
    var clientWidth = 0;
    var clientHeight = 0;

// Initialize Scroller
    this.scroller = new Scroller(render, {
        zooming: true
    });

}