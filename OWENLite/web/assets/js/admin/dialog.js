$(document).ready(function () {
    var dialog = document.querySelector('dialog');
    var showDialogButton = document.querySelector('#addQuestions');
    if (!dialog.showModal) {
        dialogPolyfill.registerDialog(dialog);
    }

    //Click on '+' button
    showDialogButton.addEventListener('click', function () {
        dialog.showModal();
        //If questions are selected, they are cleared; delete button is changed from enabled to disabled
        $(".questionContainer tbody tr td:nth-child(1)").removeClass("selectedCell");
        $("#deleteQuestions").prop('disabled', true);
    });

    dialog.querySelector('.add').addEventListener('click', function () {
        dialog.close();
        snackbarMsg(2);
    });

    dialog.querySelector('.cancel').addEventListener('click', function () {
        dialog.close();
    });

});