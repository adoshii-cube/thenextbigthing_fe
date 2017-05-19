var answeredQuestions = [];
var mQuestionAnswered = 0;
var wQuestionAnswered = 0;
var oQuestionAnswered = 0;
$(document).ready(function () {
    $('.collapse.in').prev('.panelHeading').addClass('active');
    $('#accordion, #bs-collapse')
            .on('show.bs.collapse', function (a) {
                $(a.target).prev('.panelHeading').addClass('active');
            })
            .on('hide.bs.collapse', function (a) {
                $(a.target).prev('.panelHeading').removeClass('active');
            });

    $(".question").hover(function () {
        $(this).toggleClass("mdl-shadow--3dp");
    });

    $(".radioButtons td").on("click", function () {
        var id = $(this).parent().parent().parent().attr("id");
        var qId = id.split("-")[1];
        if (answeredQuestions.length === 0 || (answeredQuestions.length > 0 && !answeredQuestions.includes(qId))) {
            answeredQuestions.push(qId);
            mQuestionAnswered++;
            $("#mQuestionCounter").text('');
            $("#mQuestionCounter").text(mQuestionAnswered + "/" + $("#mQListSize").val());
            $(this).parent().parent().parent().parent().addClass("answered");
            submitEnableDisable();
        }
    });


    $("#submit").on("click", function () {
        if (!($("#submit").attr("disabled"))) {
            submit();
        }
    });

    //setup before functions
    var typingTimer;                //timer identifier
    var doneTypingInterval = 1000;  //time in ms, 1 second for example
    var $input = $('.openTextResponse');

    //on keyup, start the countdown
    $input.on('keyup', function () {
        clearTimeout(typingTimer);
        typingTimer = setTimeout(doneTyping, doneTypingInterval);
    });

    //on keydown, clear the countdown 
    $input.on('keydown', function () {
        clearTimeout(typingTimer);
    });


    $(".score td").on("click", function () {
        var id = $(this).parent().parent().parent().attr("id");
        $("#" + id + " .radioButtons label").removeClass("is-checked");
        $("#" + id + ' .radioButtons label:eq(' + ($(this).text() - 1) + ")").addClass("is-checked");
        var qId = id.split("-")[1];
        if (answeredQuestions.length === 0 || (answeredQuestions.length > 0 && !answeredQuestions.includes(qId))) {
            answeredQuestions.push(qId);
            mQuestionAnswered++;
            $("#mQuestionCounter").text('');
            $("#mQuestionCounter").text(mQuestionAnswered + "/" + $("#mQListSize").val());
            $(this).parent().parent().parent().parent().addClass("answered");
            submitEnableDisable();
        }
    });

    $(".mood td").on("click", function () {
        var id = $(this).parent().parent().parent().attr("id");
        $("#" + id + " .radioButtons label").removeClass("is-checked");
        $("#" + id + ' .radioButtons label:eq(' + ($(this).text() - 1) + ")").addClass("is-checked");
        var qId = id.split("-")[1];
        if (answeredQuestions.length === 0 || (answeredQuestions.length > 0 && !answeredQuestions.includes(qId))) {
            answeredQuestions.push(qId);
            mQuestionAnswered++;
            $("#mQuestionCounter").text('');
            $("#mQuestionCounter").text(mQuestionAnswered + "/" + $("#mQListSize").val());
            $(this).parent().parent().parent().parent().addClass("answered");
            submitEnableDisable();
        }
    });
    $(".listOfPeople .mdl-list__item").on("click", function () {
        var id = $(this).parent().attr("id").split("-");
        var qId = id[1];

        //select/unselect the like button
        $(this).toggleClass("liked");
        //fetch the string of names liked for that question
        var listStr = $('#listOfSelectedPeople-' + qId).text();
        var listIdStr = $('#listOfSelectedId-' + qId).text();
        //if nobody has been liked...
        var listOfNames = [];
        var listOfIds = [];
        if (listStr.length === 0) {
            // add first name to the list for that question

            //Check if person has been liked or unliked. If they have been liked, add them to the list (takes care of same name issue)
            if ($(this).hasClass("liked")) {
                listOfNames.unshift($(this).find("span").eq(1).text());
                listOfIds.unshift($(this).find("input").val());
                if (answeredQuestions.length === 0 || (answeredQuestions.length > 0 && !answeredQuestions.includes(qId))) {
                    answeredQuestions.push(qId);
                    wQuestionAnswered++;
                    $("#wQuestionCounter").text('');
                    $("#wQuestionCounter").text(wQuestionAnswered + "/" + $("#wQListSize").val());
                    $(this).parent().parent().parent().addClass("answered");
                    submitEnableDisable();
                }
            }
        } else {
            //split the string into an list of strings
            listOfNames = listStr.split(',');
            listOfIds = listIdStr.split(',');

            //Check if person has been liked or unliked. If they have been liked, add them to the list (takes care of same name issue)
            if ($(this).hasClass("liked")) {
                listOfNames.unshift($(this).find("span").eq(1).text());
                listOfIds.unshift($(this).find("input").val());
            }
            //Do the following if person has been unliked
            else {
                //Iterate through listOfNames to see if name exists
                for (i = 0; i < listOfNames.length; i++) {
                    //If name exists
                    if (listOfNames[i] === $(this).find("span").eq(1).text()) {
                        var index = listOfNames.indexOf(listOfNames[i]);
                        listOfNames.splice(index, 1);
                    }

                    if (listOfIds[i] === $(this).find("input").val()) {
                        var index = listOfIds.indexOf(listOfIds[i]);
                        listOfIds.splice(index, 1);
                    }
                }
            }
        }
        $("#listOfSelectedPeople-" + qId).html(listOfNames.join(", "));
        $("#listOfSelectedId-" + qId).html(listOfIds.join(","));
        //show parent container without giving ids
        $("#listOfSelectedPeople-" + qId).parent().css("visibility", "visible");
        $("#listOfSelectedId-" + qId).css("visibility", "hidden");


        //HIDE listOfSelectedPeopleContainer if number of people liked = 0
        if ($("#smartList-" + qId + ":has(.liked)").length === 0) {
            //FIRST EMPTY/CLEAR OUT LIST
            $("#listOfSelectedPeople-" + qId).empty();
            //THEN HIDE LIST
            $("#listOfSelectedPeople-" + qId).parent().css("visibility", "hidden");
            $("#listOfSelectedId-" + qId).css("visibility", "hidden");
            if (answeredQuestions.length > 0 && answeredQuestions.includes(qId)) {
                answeredQuestions.pop(qId);
                wQuestionAnswered--;
                $("#wQuestionCounter").text('');
                $("#wQuestionCounter").text(wQuestionAnswered + "/" + $("#wQListSize").val());
                $(this).parent().parent().parent().removeClass("answered");
                submitEnableDisable();
            }
        }
    });

    $(document).keypress(function (e) {
        var id = e.target.id.split("-");
        var qId = id[1];
        if (($("#searchField-" + qId).val().length > 0) & (e.which === 13)) {

            // quick search regex            
            var qsRegex;

            $("#searchField-" + qId).keyup(debounce(function () {
                qsRegex = new RegExp($("#searchField-" + qId).val(), 'gi');
                $grid.isotope();
            }, 200));
            var $grid = jQ321('#smartList-' + qId).isotope({
                // options
                itemSelector: '#people-' + qId,
                layoutMode: 'fitRows',
                filter: function () {
                    return qsRegex ? jQ321(this).text().match(qsRegex) : true;
                }
            });
        }
    });
});

function submit() {
    var responseArr = [];

    $("div[id^='listOfSelectedId']").each(function () {
        if ($(this).length > 0) {
            var id = $(this).attr("id").split("-");
            var qId = id[1];
            var values = $(this).text().split(",");
            jQuery.each(values, function (k, v) {
                var jsonObj = {
                    "companyId": $('#comId').val(),
                    "employeeId": $('#empId').val(),
                    "questionId": qId,
                    "questionType": "WE",
                    "responseValue": "5",
                    "targetEmployee": v
                };
                responseArr.push(jsonObj);
            });
        }
    });

    // ME/MOOD response
    $(".mdl-radio").each(function () {
        if ($(this).hasClass("is-checked")) {
            var id = $(this).attr("for").split("-");
            var value = $(this).find("input")[0].value;
            var jsonObj = {
                "companyId": $('#comId').val(),
                "employeeId": $('#empId').val(),
                "questionId": id[1],
                "questionType": jQuery('#qtype_' + id[1]).val(),
                "responseValue": value
            };
            responseArr.push(jsonObj);
        }
    });

    // OPENTEXT response
    $(".openTextResponse").each(function () {
        if ($(this)[0].value !== "") {
            var id = $(this)[0].id.split("-");
            var value = $(this)[0].value;
            var jsonObj = {
                "companyId": $('#comId').val(),
                "employeeId": $('#empId').val(),
                "questionId": id[1],
                "questionType": jQuery('#qtype_' + id[1]).val(),
                "responseString": value
            };
            responseArr.push(jsonObj);
        }
    });
    singleSubmitData(responseArr);
}

function singleSubmitData(responseArr) {
    var empid = $('#empId').val();
    console.log("entering singleSubmitData for empId : " + empid);
    console.log("singleSubmitData analyzing single_submit_rating");
    var postData = {'emp_rating': JSON.stringify(responseArr)};
    console.log("singleSubmitData postData : " + postData);
    $.ajax({
        type: "POST",
        url: "../employee/survey-submit.jsp",
        data: postData,
        dataType: 'JSON',
        async: false,
        success: function (resp) {
            console.log("singleSubmitData inside ajax success ");
            window.location.href = 'thankyou.jsp';
        },
        error: function (resp, err) {
            console.log("singleSubmitData error message : " + err);
        }
    });
    console.log("exiting singleSubmitData");
}

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

function submitEnableDisable() {
    var qListSize = $('#qListSize').val();
    if (answeredQuestions.length.toString() === qListSize) {
        $('#submit').addClass('mdl-color--indigo-500 mdl-color-text--white');
        $('#submit').prop("disabled", false); // Element(s) are now enabled.

    } else if (answeredQuestions.length.toString() !== qListSize) {
        $('#submit').removeClass('mdl-color--indigo-500 mdl-color-text--white');
        $('#submit').prop("disabled", true);
    }
}

//user is "finished typing," do something
function doneTyping() {
    //do something
    $('.openTextResponse').each(function () {
        var id = $(this).attr("id");
        var qId = id.split("-")[1];
        var value = $(this).val();
        if ((value.length > 0) && ((answeredQuestions.length === 0) || (answeredQuestions.length > 0 && !answeredQuestions.includes(qId)))) {
            answeredQuestions.push(qId);
            oQuestionAnswered++;
            $("#oQuestionCounter").text('');
            $("#oQuestionCounter").text(oQuestionAnswered + "/" + $("#oQListSize").val());
            $(this).parent().parent().addClass("answered");
            submitEnableDisable();
        } else if (value.length === 0 && answeredQuestions.includes(qId)) {
            answeredQuestions.pop(qId);
            oQuestionAnswered--;
            $("#oQuestionCounter").text('');
            $("#oQuestionCounter").text(oQuestionAnswered + "/" + $("#oQListSize").val());
            $(this).parent().parent().removeClass("answered");
            submitEnableDisable();
        }
    });
}

