<%-- 
    Document   : questions
    Created on : 18 May, 2017, 5:26:48 PM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>OWEN Analytics - AI driven people solutions</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <meta content="IE=11;IE=Edge" http-equiv="X-UA-Compatible">
        <meta charset="utf-8">

        <link href="../assets/css/material.min.css" rel="stylesheet" type="text/css">
        <!--<link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link href="../assets/css/admin.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <link rel='shortcut icon' type='image/x-icon' href='../assets/images/OWEN_Favicon.ico'/>

        <!-- Chrome, Firefox OS and Opera -->
        <meta name="theme-color" content="#607D8B">
        <!-- Windows Phone -->
        <meta name="msapplication-navbutton-color" content="#607D8B">
        <!-- iOS Safari -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#607D8B">
    </head>
    <body>
        <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
            <header class="mdl-layout__header mdl-layout__header--waterfall mdl-color--blue-grey-600">
                <div class="mdl-layout__header-row">
                    <!-- Title -->
                    <a id="switchUser">
                        <span class="android-title mdl-layout-title">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUser">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
                        </a>
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Employee</li>
                        </a>
                    </ul>
                    <!-- Add spacer, to align navigation to the right -->
                    <div class="mdl-layout-spacer"></div>
                    <!-- Navigation -->
                    <!--<div class="android-navigation-container">-->
                    <nav class="mdl-navigation">
                        <a class="mdl-navigation__link" href="index.jsp">Employee Details</a>
                        <a class="mdl-navigation__link" href="">Add/Remove Questions</a>
                    </nav>
                    <!--</div>-->
                    <!-- Right aligned menu below button -->
                    <button id="header-menu"
                            class="mdl-button mdl-js-button mdl-button--icon">
                        <i class="material-icons">more_vert</i>
                    </button>
                    <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                        for="header-menu">
                        <li class="mdl-menu__item">Help & Feedback</li>
                        <li class="mdl-menu__item">Settings</li>
                        <li disabled class="mdl-menu__item">Sign Out</li>
                    </ul>
                    <a>
                        <span class="android-mobile-title mdl-layout-title" id="switchUserMobile">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUserMobile">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
                        </a>
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Emplyee</li>
                        </a>
                    </ul>
                </div>
            </header>
            <div class="mdl-layout__drawer">
                <span class="mdl-layout-title">
                    <img class="android-logo-image" src="../assets/images/OWEN_Logo.png">
                </span>
                <nav class="mdl-navigation">
                    <a class="mdl-navigation__link" href="">Link</a>
                </nav>
            </div>
            <main class="android-content mdl-layout__content">
                <div class="page-content">
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp">
                            
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="../assets/js/material.min.js"></script>
    </body>
</html>
