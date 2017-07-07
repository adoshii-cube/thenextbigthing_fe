/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {

    $("#uploadBtn").on("change", function () {
        $("#uploadFile").val(this.files[0].name);
    });

    $("#uploadSubmit").on("click", function () {
        var input = document.getElementById('uploadBtn');
        if (input.files.length === 0) {
            snackbarMsg(1);
        } else {
            var myFormData = new FormData();
            myFormData.append('blablabla', input.files[0]);
            $.ajax({
                url: "../admin/uploadFile.jsp",
                type: 'POST',
                data: myFormData,
                contentType: false,
                cache: false,
                processData: false,
                success: function () {
                    snackbarMsg(2);
                },
                error: function () {
                    snackbarMsg(3);
                }
            });
        }
    });

    $('#btnExport').on('click', function () {
        download("firstName, lastName, address", "template.csv", "text/plain");
    });

});

function snackbarMsg(flag) {
    var snackbarContainer = document.querySelector('#snackbar');
    if (flag === 1) {
        var data = {message: 'Please select a file to upload'};
    } else if (flag === 2) {
        var data = {message: 'File uploaded successfully'};
    } else if (flag === 3) {
        var data = {message: 'Failed to upload file. Please try again'};
    }
    'use strict';
    snackbarContainer.MaterialSnackbar.showSnackbar(data);
}