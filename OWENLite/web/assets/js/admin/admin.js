/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
    changeFooterStatus();

    if ($(".uploadBtn").length > 0) {
        document.getElementById("uploadBtn").onchange = function () {
            document.getElementById("uploadFile").value = this.files[0].name;
        };
    }

    $(document).keypress(function (e) {
        if (($(".quicksearch").val().length > 0) & (e.which === 13)) {

            // quick search regex            
            var qsRegex;

            $('.quicksearch').keyup(debounce(function () {
                qsRegex = new RegExp($(".quicksearch").val(), 'gi');
                $grid.isotope();
            }, 200));

            var $grid = $('.newQuestionsContainer').isotope({
                // options
                itemSelector: 'tr',
                layoutMode: 'vertical',
                filter: function () {
                    return qsRegex ? $(this).text().match(qsRegex) : true;
                }
            });
        }
    });

    $("#saveDates").on("click", function () {
        var startDate = $("#date-start").val();
        var endDate = $("#date-end").val();
        var jsonObj = {
            "startDate": startDate,
            "endDate": endDate
        };
        var postData = {'jsonObj': JSON.stringify(jsonObj)};
        jQuery.ajax({
            type: "POST",
            url: "../admin/updateQuestionDate.jsp",
            data: postData,
//            dataType: 'JSON',
            async: false,
            success: function (resp) {
                //TODO : REFRESH DIV OF QUESTION LISTS
                console.log("updated question date successfully");
            },
            error: function (resp, err) {
                console.log("update question date error messsage : " + err);
            }
        });
        $(this).prop("disabled", true);
        snackbarMsg(4);
    });

    updateStartDate();
    updateEndDate();

});

// debounce so filtering doesn't happen every millisecond
function debounce(fn, threshold) {
    var timeout;
    return function debounced() {
        if (timeout) {
            clearTimeout(timeout);
        }
        function delayed() {
            fn();
            timeout = null;
        }
        timeout = setTimeout(delayed, threshold || 100);
    };
}

function changeFooterStatus() {

    //If empty state is not visible, meaning questions exist, enable the start/end dates and save button
    if ($(".emptyState").length === 0) {
        $("#date-start").prop("disabled", false);
        $("#date-end").prop("disabled", false);
    } else
            //Else empty state is visible, meaning no questions exist, disable the start/end dates and save button
            {
                $("#date-start").prop("disabled", true);
                $("#date-end").prop("disabled", true);
                $("#saveDates").prop("disabled", true);
            }
}

function snackbarMsg(flag) {
    var snackbarContainer = document.querySelector('#snackbar');
    if (flag === 1) {
        var data = {message: 'Questions deleted successfully'};
    } else if (flag === 2) {
        var data = {message: 'Questions added successfully'};
    } else if (flag === 3) {
        var data = {message: 'Please select both start and end dates'};
    } else if (flag === 4) {
        var data = {message: 'Dates saved successfully'};
    }
    'use strict';
    snackbarContainer.MaterialSnackbar.showSnackbar(data);
}

function deleteQuestions() {
    $("#loader").css("visibility", "visible");
    var qIdArray = [];
    $(".questionContainer tbody tr.selectedRow").each(function (o, v) {
        var jsonObj = {
            "questionId": $(this).attr("id")
        };
        qIdArray.push(jsonObj);
    });
    var postData = {'qIdArray': JSON.stringify(qIdArray)};
    jQuery.ajax({
        type: "POST",
        url: "../admin/deleteQuestion.jsp",
        data: postData,
        success: function (resp) {
            $(".questionContainer").remove();
            $("#questionTable").html(resp);
            componentHandler.upgradeDom('MaterialDataTable');
            updateQuestionMasterList();
            updateStartDate();
            updateEndDate();
            $("#loader").css("visibility", "hidden");
            snackbarMsg(1);
        },
        error: function (resp, err) {
            console.log("deleteQuestions error messsage : " + err);
        }
    });
}

function addQuestions() {
    $("#loader").css("visibility", "visible");
    var qIdArray = [];

    var startDateCalc = new Date(new Date().getTime() + (2 * 24 * 60 * 60 * 1000));
    var startDate = startDateCalc.getFullYear() + "-" + (startDateCalc.getMonth() + 1) + '-' + startDateCalc.getDate();

    var endDateCalc = new Date(new Date().getTime() + (9 * 24 * 60 * 60 * 1000));
    var endDate = endDateCalc.getFullYear() + "-" + (endDateCalc.getMonth() + 1) + '-' + endDateCalc.getDate();

    if ($("#startDate").val() !== undefined) {
        startDate = $("#startDate").val();
    }
    if ($("#endDate").val() !== undefined) {
        endDate = $("#endDate").val();
    }
    $(".newQuestionsContainer tr.is-selected").each(function (o, v) {
        var jsonObj = {
            "questionId": $(this).attr("id"),
            "startDate": startDate.toString(),
            "endDate": endDate.toString()
        };
        qIdArray.push(jsonObj);
    });
    var postData = {'qIdArray': JSON.stringify(qIdArray)};
    jQuery.ajax({
        type: "POST",
        url: "../admin/addQuestion.jsp",
        data: postData,
        success: function (resp) {
            $(".questionContainer").remove();
            $("#questionTable").html(resp);
            componentHandler.upgradeDom('MaterialDataTable');
            updateQuestionMasterList();
            updateStartDate();
            updateEndDate();
            $("#loader").css("visibility", "hidden");
            snackbarMsg(2);
        },
        error: function (resp, err) {
            console.log("adding questions error message : " + err);
        }
    });
}

function selectQuestionsToDelete(questionRow) {
    $(questionRow).find("td:first-child").toggleClass("selectedCell");
    $(questionRow).toggleClass("selectedRow");
    if ($(".questionContainer:has(.selectedCell)").length > 0) {
        $("#deleteQuestions").prop('disabled', false);
    }
    if ($(".questionContainer:has(.selectedCell)").length === 0) {
        $("#deleteQuestions").prop('disabled', true);
    }
}

function selectQuestionsToAdd() {
    setTimeout(function () {
        if ($(".newQuestionsContainer:has(.is-selected)").length > 0) {
            $(".add").prop("disabled", false);
        } else {
            $(".add").prop("disabled", true);
        }
    }, 1000);
}

function updateQuestionMasterList() {
    jQuery.ajax({
        type: "POST",
        url: "../admin/updateMasterQuestionList.jsp",
        success: function (resp) {
            $("#questionMaster").remove();
            $("#questionMasterContainer").html(resp);
            componentHandler.upgradeDom('MaterialDataTable');
            componentHandler.upgradeDom('MaterialTextfield');
        },
        error: function (resp, err) {
            console.log("deleteQuestions error messsage : " + err);
        }
    });
}

function updateStartDate() {
    //Check for Empty State. If empty generate empty date picker, else pass values from DB
    if ($("#startDate").length === 0) {
        $('#date-start').val("");
        $('#date-start').parent().removeClass("is-focused");
        $('#date-start').bootstrapMaterialDatePicker({
            weekStart: 0, time: false, format: 'YYYY-MM-DD', minDate: new Date()
        }).on('change', function (e, date) {
            $(this).parent().addClass("is-focused");
            //Clear end date    
            $("#date-end")[0].value = "";
            //Set earliest end date as new start date    
            $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            $("#saveDates").prop("disabled", true);
            snackbarMsg(3);
        });
    } else {
        $('#date-start').bootstrapMaterialDatePicker({
            weekStart: 0, time: false, format: 'YYYY-MM-DD', minDate: new Date(), currentDate: new Date($("#startDate").val())
        }).on('change', function (e, date) {
            $(this).parent().addClass("is-focused");
            //Clear end date    
            $("#date-end")[0].value = "";
            //Set earliest end date as new start date    
            $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            $("#saveDates").prop("disabled", true);
            snackbarMsg(3);
        });
        $("#date-start")[0].value = $("#startDate").val();
        $("#date-start").parent().addClass("is-focused");
        $('#date-start').parent().removeClass("is-disabled");
    }
    var today = new Date();
    //If today's date is greater than or equal to the start date, disable the start date, so it cannot be edited
    if (today >= new Date($("#date-start")[0].value)) {
        console.log("taking care...");
        $("#date-start").parent().addClass("is-focused");
        $("#date-start").prop("disabled", true);
    }
}

function updateEndDate() {
    if ($("#endDate").length === 0) {
        $('#date-end').val("");
        $('#date-end').parent().removeClass("is-focused");

        $('#date-end').bootstrapMaterialDatePicker({
            weekStart: 0, time: false, format: 'YYYY-MM-DD', minDate: new Date()
        });
    } else {
        $('#date-end').bootstrapMaterialDatePicker({
            weekStart: 0, time: false, format: 'YYYY-MM-DD', minDate: new Date($("#startDate").val()), currentDate: new Date($("#endDate").val())}).on('change', function (e, date) {
            $(this).parent().addClass("is-focused");
            $("#saveDates").prop("disabled", false);
        });
        $("#date-end")[0].value = $("#endDate").val();
        $('#date-end').parent().removeClass("is-disabled");
    }
    //To ensure that the text for end date does not get overwritten by the label
    if ($("#date-end")[0].value.length > 0) {
        $("#date-end").parent().addClass("is-focused");
    }
}