<%-- 
    Document   : index
    Created on : 9 May, 2017, 10:15:33 AM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <title>OWEN Analytics - AI driven people solutions</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <meta content="IE=11;IE=Edge" http-equiv="X-UA-Compatible">
        <meta charset="utf-8">

        <link href="assets/css/material.min.css" rel="stylesheet" type="text/css">
        <!--<link href="assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
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
            <header class="mdl-layout__header mdl-layout__header--waterfall">
                <div class="mdl-layout__header-row">
                    <!--Title--> 
                    <a href="index">
                        <span class="android-title mdl-layout-title">
                            <img class="android-logo-image" src="assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <!--Add spacer, to align navigation to the right--> 
                    <div class="mdl-layout-spacer"></div>
                    <a href="index">
                        <span class="android-mobile-title mdl-layout-title">
                            <img class="android-logo-image" src="assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                </div>
            </header>
            <main class="android-content mdl-layout__content">
                <div class="page-content">
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--8-col-phone mdl-card mdl-shadow--3dp">
                            <div class="mdl-card__title mdl-typography--display-1-color-contrast">
                                Welcome to OWEN
                            </div>
                            <div class="mdl-card__title">
                                Please select a role
                            </div>

                            <div class="role-container">
                                <%if (isAdmin) {%>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--8-col-phone mdl-card mdl-shadow--3dp admin">
                                    <div class="mdl-card__title mdl-card--expand">
                                        <h2 class="mdl-card__title-text">ADMIN</h2>
                                    </div>
                                    <div class="mdl-card__supporting-text">
                                        <p>
                                            Upload employee master list
                                            <br>Add/remove questions
                                            <br>Change frequency of survey
                                        </p>
                                    </div>
                                    <div class="mdl-card__actions mdl-card--border">
                                        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" href='admin/'>
                                            PROCEED
                                        </a>
                                    </div>
                                </div>
                                <%}%>
                                <%if (isHR) {%> 
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--8-col-phone mdl-card mdl-shadow--3dp hr">
                                    <div class="mdl-card__title mdl-card--expand">
                                        <h2 class="mdl-card__title-text">HR</h2>
                                    </div>
                                    <div class="mdl-card__supporting-text">
                                        <p>
                                            Monitor sentiment 
                                            <br>Learn key themes being spoken about
                                            <br>Examine key metrics
                                        </p>
                                    </div>
                                    <div class="mdl-card__actions mdl-card--border">
                                        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" href='hr/'>
                                            PROCEED
                                        </a>
                                    </div>
                                </div>
                                <%}%>
                                <%if (isEmployee) {%>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--8-col-phone mdl-card mdl-shadow--3dp employee">
                                    <div class="mdl-card__title mdl-card--expand">
                                        <h2 class="mdl-card__title-text">EMPLOYEE</h2>
                                    </div>
                                    <div class="mdl-card__supporting-text">
                                        <p>
                                            Undertake surveys
                                            <br>4 question types
                                            <br>Responsive
                                        </p>
                                    </div>
                                    <div class="mdl-card__actions mdl-card--border">
                                        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" href="employee/">
                                            PROCEED
                                        </a>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="assets/js/material.min.js"></script>
    </body>
</html>
