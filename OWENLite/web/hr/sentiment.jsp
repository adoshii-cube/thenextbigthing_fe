<%-- 
    Document   : sentiment
    Created on : 20 Jun, 2017, 4:23:13 PM
    Author     : adoshi
--%>

<%@page import="java.lang.String"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.owen.filter.FilterHelper"%>
<%@page import="org.owen.filter.Filter"%>
<%@page import="org.owen.relationship.RelationshipHelper"%>
<%@page import="org.owen.relationship.Relationship"%>
<%@include file="../common.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>OWEN Analytics - AI driven people solutions</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <meta content="IE=11;IE=Edge" http-equiv="X-UA-Compatible">
        <meta charset="utf-8">

        <link href="../assets/css/material.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/mdl-selectfield.min.css" rel="stylesheet" type="text/css">
        <!--<link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link href="../assets/css/hr_sentiment.css" rel="stylesheet" type="text/css">      
        <!--<link href="../assets/css/dc.css" rel="stylesheet" type="text/css"/>-->
        <!--<link href="../assets/css/dc-tooltip-mixin.css" rel="stylesheet" type="text/css">-->

        <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link href="../assets/css/styles.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!--<script src="../assets/js/hr/index/cytoscape.min.js"></script>-->

        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/highcharts-more.js"></script>
        <script src="https://code.highcharts.com/modules/solid-gauge.js"></script>



        <link rel='shortcut icon' type='image/x-icon' href='../assets/images/OWEN_Favicon.ico'/>

        <!-- Chrome, Firefox OS and Opera -->
        <meta name="theme-color" content="#303f9f">
        <!-- Windows Phone -->
        <meta name="msapplication-navbutton-color" content="#303f9f">
        <!-- iOS Safari -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#303f9f">
    </head>
    <body>
        <div class="mdl-layout mdl-js-layout">
            <header class="mdl-layout__header mdl-layout__header--scroll mdl-color--indigo-500">
                <div class="mdl-layout__header-row">
                    <!-- Title -->
                    <a id="switchUser">
                        <span class="android-title mdl-layout-title">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <%if (isAdmin || isEmployee) {%>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUser">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isAdmin) {%>
                        <a href="../admin/index.jsp">
                            <li class="mdl-menu__item">Admin</li>
                        </a>
                        <%}
                            if (isEmployee) {%>         
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Employee</li>
                        </a>
                        <%}%>
                    </ul>
                    <%}%>
                    <!-- Add spacer, to align navigation to the right -->
                    <div class="mdl-layout-spacer"></div>
                    <!-- Navigation -->
                    <!--<div class="android-navigation-container">-->
                    <nav class="mdl-navigation">
                        <a class="mdl-navigation__link" href="#relationship">Relationship</a>
                        <a class="mdl-navigation__link" href="#sentiment">Feedback</a>
                        <a class="mdl-navigation__link" href="#selfPerception">Engagement</a>
                        <a class="mdl-navigation__link" href="explore.jsp">Explore</a>
                    </nav>

                    <button id="switch-role-menu"
                            class="mdl-button mdl-js-button mdl-button--icon">
                        <i class="material-icons">account_circle</i>
                    </button>
                    <%if (isAdmin || isHR) {%>
                    <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                        for="switch-role-menu">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isAdmin) {%>
                        <a href="../admin/index.jsp">
                            <li class="mdl-menu__item">Admin</li>
                        </a>
                        <%}
                            if (isEmployee) {%>         
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Employee</li>
                        </a>
                        <%}%>
                    </ul>
                    <%}%>
                    <button id="header-menu"
                            class="mdl-button mdl-js-button mdl-button--icon">
                        <i class="material-icons">more_vert</i>
                    </button>
                    <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                        for="header-menu">
                        <li class="mdl-menu__item">Help & Feedback</li>
                        <li class="mdl-menu__item">Settings</li>
                        <a href="../signout.jsp" id="signOut">
                            <li class="mdl-menu__item"> 
                                Sign out
                            </li>
                        </a>
                    </ul>
                    <!--</div>-->
                    <!-- Right aligned menu below button -->

                    <a>
                        <span class="android-mobile-title mdl-layout-title" id="switchUserMobile">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <%if (isAdmin || isEmployee) {%>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUserMobile">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isAdmin) {%>
                        <li class="mdl-menu__item">Admin</li>
                            <%}
                                if (isEmployee) {%>
                        <li class="mdl-menu__item">Employee</li>
                            <%}%>
                    </ul>
                    <%}%>
                </div>
            </header>
            <main class="android-content mdl-layout__content">
                <div class="page-content">
                    <div class="android-card-container mdl-grid filterPanelParent">
                        <!--</div>-->
                        <!--<div class="android-card-container mdl-grid">-->
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                            <div class="mdl-card__title font2x">Open Text Feedback</div>
                            <div class="mdl-grid sectionGridLayoutWidth">
                                <div class="mdl-cell mdl-cell--8-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                                    <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label" id="dropdown_sentimentContainer">
                                        <select id="dropdown_sentiment" name="sentiment" class="mdl-selectfield__select" required>
                                            <option value="1">How is technology helping you in your day-to-day work?</option>
                                            <option value="2">How do you associate with the core values of the company?</option>
                                            <option value="3">How well are processes streamlined for efficient working?</option>
                                        </select>
                                        <label class="mdl-selectfield__label" for="sentiment">Question</label>
                                        <span class="mdl-selectfield__error">Please select a theme</span>
                                    </div>
                                </div>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                    <div class="responseCountContainer">Responses:<div class="responseCount" id="openTextResponses">81</div></div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Overall Sentiment</div>
                                    <div class="mdl-card__supporting-text" id="HC_Gauge"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Sentiment Distribution</div>
                                    <div class="mdl-card__supporting-text" id="HC_StackedBar"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Key Words</div>
                                    <div class="mdl-card__supporting-text" id="HC_WordCloud"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Associated Words</div>
                                    <div class="mdl-card__supporting-text" id="HC_Table">
                                        <table class="mdl-data-table mdl-js-data-table">
                                            <thead>
                                                <tr>
                                                    <th class="mdl-data-table__cell--non-numeric">Key Words</th>
                                                    <th class="mdl-data-table__cell--non-numeric">Associated Words</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr id="template">
                                                    <td class="mdl-data-table__cell--non-numeric word"></td>
                                                    <td class="mdl-data-table__cell--non-numeric trigram"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </main>
        </div>
        <script src="../assets/js/material.min.js"></script>
        <script src="../assets/js/mdl-selectfield.min.js"></script>
        <script src="../assets/js/hr/index/stickyfill.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="../assets/js/employee/employee.js"></script>
        <script src="../assets/js/hr/index/hr_sentiment.js"></script>
    </body>
</html>
