/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
   
    document.getElementById("uploadBtn").onchange = function () {
        document.getElementById("uploadFile").value = this.files[0].name;
    };

    $('#btnExport').on('click', function () {
        download("firstName, lastName, address", "template.csv", "text/plain");
    });
    
});