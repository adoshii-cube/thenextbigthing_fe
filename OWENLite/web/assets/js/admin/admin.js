/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
    $('#btnExport').on('click', function () {
        download("firstName, lastName, address", "template.csv", "text/plain");
    });

    document.getElementById("uploadBtn").onchange = function () {
        document.getElementById("uploadFile").value = this.files[0].name;
    };

    $(".questionContainer tr").on("click", function () {
        //Check if row is header. Do not change class of header
        var is_element_header_row = $(this).parent().is("thead"); //true or false

        if (!is_element_header_row) {
//            $(this).toggleClass("selectedQuestion");
            $(this).find("td:first-child").toggleClass("selectedCell");


            if ($(".questionContainer:has(.selectedCell)").length > 0) {
                $("#deleteQuestions").prop('disabled', false);
            }
            if ($(".questionContainer:has(.selectedCell)").length === 0) {
                $("#deleteQuestions").prop('disabled', true);
            }
        }
    });

    var dialog = document.querySelector('dialog');
    var showDialogButton = document.querySelector('#addQuestions');
    if (!dialog.showModal) {
        dialogPolyfill.registerDialog(dialog);
    }
    showDialogButton.addEventListener('click', function () {
        dialog.showModal();
    });
    dialog.querySelector('.add').addEventListener('click', function () {
        dialog.close();
    });

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

    $('#date-end').bootstrapMaterialDatePicker
            ({
                weekStart: 0, time: false, format: 'DD/MM/YYYY'
            });
    $('#date-start').bootstrapMaterialDatePicker({
        weekStart: 0, time: false, format: 'DD/MM/YYYY'
    }).on('change', function (e, date) {
        $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
    });
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