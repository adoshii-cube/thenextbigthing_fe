<%-- 
    Document   : index
    Created on : 18 May, 2017, 5:26:34 PM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
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
                    <!-- Add spacer, to align navigation to the right -->
                    <div class="mdl-layout-spacer"></div>
                    <!-- Navigation -->
                    <!--<div class="android-navigation-container">-->
                    <nav class="mdl-navigation">
                        <a class="mdl-navigation__link selected" href="">Data</a>
                        <a class="mdl-navigation__link" href="questions.jsp">Survey</a>
                    </nav>
                    <!--</div>-->
                    <button id="switch-role-menu"
                            class="mdl-button mdl-js-button mdl-button--icon">
                        <i class="material-icons">account_circle</i>
                    </button>
                    <%if (isEmployee || isHR) {%>
                    <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                        for="switch-role-menu">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isHR) {%>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
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
                    <a>
                        <span class="android-mobile-title mdl-layout-title" id="switchUserMobile">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <%if (isEmployee || isHR) {%>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUserMobile">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isHR) {%>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
                        </a>
                        <%
                            }
                            if (isEmployee) {%>
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Employee</li>
                        </a>
                        <%}%>
                    </ul>
                    <%}%>
                </div>
            </header>
            <!--            <div class="mdl-layout__drawer">
                            <span class="mdl-layout-title">
                                <img class="android-logo-image" src="../assets/images/OWEN_Logo.png">
                            </span>
                            <nav class="mdl-navigation">
                                <a class="mdl-navigation__link" href="">Link</a>
                            </nav>
                        </div>-->
            <main class="android-content mdl-layout__content">
                <div class="page-content">
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp">
                            <!--<div class="mdl-card__title mdl-typography--display-1-color-contrast">-->
                            <!--Welcome to OWEN-->
                            <!--</div>-->
                            <div class="mdl-card__title">
                                Instructions: Download the master template and/or upload your company master template to activate a survey for your company
                            </div>
                            <div class="role-container">
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp download">
                                    <div class="mdl-card__title mdl-card--expand">
                                        <h2 class="mdl-card__title-text">VIEW EMPLOYEE MASTER</h2>
                                    </div>
                                    <div class="mdl-card__supporting-text">
                                        <p>
                                            Download the employee master list
                                            <br>Convert your company employee master list to this format
                                            <br>Upload it using the Upload feature to load your company into OWEN
                                        </p>
                                    </div>
                                    <div class="mdl-card__actions mdl-card--border">
                                        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" href="#" id="btnExport" >DOWNLOAD</a>
                                        <input type="hidden" id="templateHeader" value="<%=templateHeader%>"/>
                                    </div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp upload">
                                    <div class="mdl-card__title mdl-card--expand">
                                        <h2 class="mdl-card__title-text">ACTIVATE SURVEY</h2>
                                    </div>
                                    <div class="mdl-card__supporting-text">
                                        <p>
                                            Upload your company's employee master list
                                            <br>Employees will be notified of their login credentials via email
                                            <br>Ensure that only a csv format file is uploaded, in the format specified
                                        </p>
                                    </div>
                                    <div class="mdl-card__actions mdl-card--border">
                                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--file">
                                            <input class="mdl-textfield__input" placeholder="Upload file here" type="text" id="uploadFile"  readonly/>
                                            <div class="mdl-button mdl-button--primary mdl-button--icon mdl-button--file">
                                                <i class="material-icons">attach_file</i>
                                                <input type="file" name = "file" id="uploadBtn" accept=".csv">
                                            </div>
                                        </div>
                                        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" type = "submit" id="uploadSubmit">Upload File</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <div id="snackbar" class="mdl-js-snackbar mdl-snackbar">
            <div class="mdl-snackbar__text"></div>
            <button class="mdl-snackbar__action" type="button"></button>
        </div>
        <script src="../assets/js/material.min.js"></script>
        <script src="../assets/js/admin/template.js"></script>
        <script src="../assets/js/admin/download.js"></script>
    </body>
</html>
