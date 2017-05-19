<%-- 
    Document   : index
    Created on : 9 May, 2017, 10:15:33 AM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@include file="common.jsp" %>--%>

<!DOCTYPE html>
<html>
    <head>
        <title>OWEN Analytics - AI driven people solutions</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <meta content="IE=11;IE=Edge" http-equiv="X-UA-Compatible">
        <meta charset="utf-8">

        <link href="assets/css/material.min.css" rel="stylesheet" type="text/css">
        
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link href="assets/css/styles.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <link rel='shortcut icon' type='image/x-icon' href='assets/images/OWEN_Favicon.ico'/>

        <!-- Chrome, Firefox OS and Opera -->
        <meta name="theme-color" content="#303f9f">
        <!-- Windows Phone -->
        <meta name="msapplication-navbutton-color" content="#303f9f">
        <!-- iOS Safari -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#303f9f">
    </head>
    <body>
        <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">

            <main class="android-content mdl-layout__content">
                <div class="page-content login-page">
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-layout-spacer"></div>
                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp login">
                            <div class="mdl-card__title">
                                <img class="android-logo-image" src="assets/images/OWEN_Logo.png" alt="OWEN Logo">
                            </div>
                            <div class="mdl-card__supporting-text">
                                <form method="post" action="login-check.jsp">
                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label form-width">
                                        <input class="mdl-textfield__input" pattern="[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$" type="text" id="username" name="username">
                                        <label class="mdl-textfield__label" for="username">Username</label>
                                        <span class="mdl-textfield__error">Please enter a valid username</span>
                                    </div>
                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label form-width">
                                        <input class="mdl-textfield__input" type="password" id="password" name="password">
                                        <label class="mdl-textfield__label" for="password">Password</label>
                                        <span class="mdl-textfield__error">Please enter a password</span>
                                    </div>
                                    <div class="mdl-card__actions">
                                        <div class="mdl-layout-spacer"></div>
                                        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-color--indigo-500 mdl-color-text--white" type="submit" >LOGIN</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="mdl-layout-spacer"></div>
                    </div>
                </div>
            </main>
            <div id="demo-snackbar-example" class="mdl-js-snackbar mdl-snackbar">
                <div class="mdl-snackbar__text"></div>
                <button class="mdl-snackbar__action" type="button"></button>
            </div>
        </div>
        <script src="assets/js/material.min.js"></script>
        <% if (request.getParameter("loginFailure") != null ) {%>
        <script>
            componentHandler.upgradeDom('MaterialSnackbar');
            (function () {
                'use strict';
                var snackbarContainer = document.querySelector('#demo-snackbar-example');
                var data = {
                    message: 'Invalid username/password. Please try again.',
                    timeout: 7000
                };
                snackbarContainer.MaterialSnackbar.showSnackbar(data);
            }());
        </script>

        <% }%>

    </body>
</html>
