/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
    var randomNumber = randomIntFromInterval(1, 9);
    var page = $(".login-page-content");
    if (randomNumber === 1) {
        page.addClass("bg1");
    } else if (randomNumber === 2) {
        page.addClass("bg2");
    } else if (randomNumber === 3) {
        page.addClass("bg3");
    } else if (randomNumber === 4) {
        page.addClass("bg4");
    } else if (randomNumber === 5) {
        page.addClass("bg5");
    } else if (randomNumber === 6) {
        page.addClass("bg6");
    } else if (randomNumber === 7) {
        page.addClass("bg7");
    }
});

function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
}