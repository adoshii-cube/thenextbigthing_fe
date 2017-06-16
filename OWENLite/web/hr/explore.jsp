<%-- 
    Document   : explore
    Created on : 17 May, 2017, 10:45:12 AM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>

<!DOCTYPE html>
<html>
    <title>OWEN Analytics - AI driven people solutions</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <meta content="IE=11;IE=Edge" http-equiv="X-UA-Compatible">
    <meta charset="utf-8">

    <link href="../assets/css/material.min.css" rel="stylesheet" type="text/css">

    <!--<link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link href="../assets/css/hr.css" rel="stylesheet" type="text/css">      

    <!-- external libs from cdnjs -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <!-- PivotTable.js libs from ../dist -->
    <link href="../assets/css/pivot.min.css" rel="stylesheet" type="text/css">
    <script src="../assets/js/hr/explore/pivot.min.js"></script>
    <script src="../assets/js/hr/explore/c3_renderers.js"></script>
    <!--<script type="text/javascript" src="../dist/c3_renderers.js"></script>-->

    <!-- optional: mobile support with jqueryui-touch-punch -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>


    <link rel='shortcut icon' type='image/x-icon' href='../assets/images/OWEN_Favicon.ico'/>

    <!-- Chrome, Firefox OS and Opera -->
    <meta name="theme-color" content="#ff9800">
    <!-- Windows Phone -->
    <meta name="msapplication-navbutton-color" content="#ff9800">
    <!-- iOS Safari -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="#ff9800">
</head>

<body>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
        <header class="mdl-layout__header mdl-layout__header--waterfall mdl-color--orange-500">
            <div class="mdl-layout__header-row">
                <!-- Title -->
                <a id="switchUser">
                    <span class="android-title mdl-layout-title">
                        <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                    </span>
                </a>
                <%if (isEmployee || isAdmin) {%>

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
                    <a class="mdl-navigation__link" href="index.jsp#relationship">Relationship</a>
                    <a class="mdl-navigation__link" href="index.jsp#sentiment">Sentiment</a>
                    <a class="mdl-navigation__link" href="index.jsp#selfPerception">Self Perception</a>
                    <a class="mdl-navigation__link" href="">Explore</a>
                </nav>
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
                <%if (isEmployee || isAdmin) {%>
                <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                    for="switchUserMobile">
                    <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                        <%if (isAdmin) {%>
                    <a href="../admin/index.jsp">
                        <li class="mdl-menu__item">Admin</li>
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
<!--        <div class="mdl-layout__drawer">
            <span class="mdl-layout-title">
                <img class="android-logo-image" src="../assets/images/OWEN_Logo.png">
            </span>
            <nav class="mdl-navigation">
                <a class="mdl-navigation__link" href="">Link</a>
            </nav>
        </div>-->
        <main class="android-content mdl-layout__content">
            <div class="page-content">
                <div class="android-card-container mdl-grid explore">
                    <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp">
                        <div class="mdl-card__title">Pivot</div>
                        <div class="mdl-card__supporting-text" id="pivotTable">

                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script src="../assets/js/material.min.js"></script>
    <script type="text/javascript">
//https://github.com/nicolaskruchten/pivottable
//https://github.com/nicolaskruchten/pivottable
        $(function () {

            var renderers = $.extend($.pivotUtilities.renderers,
                    $.pivotUtilities.c3_renderers);

            $.getJSON("mps.json", function (mps) {
                $("#pivotTable").pivotUI(mps, {
                    renderers: renderers,
                    cols: ["Party"], rows: ["Province"],
                    rendererName: "Horizontal Stacked Bar Chart",
                    rowOrder: "value_z_to_a", colOrder: "value_z_to_a"
//                    rendererOptions: {
//                        c3: {data: {colors: {
//                                    Liberal: '#dc3912', Conservative: '#3366cc', NDP: '#ff9900',
//                                    Green: '#109618', 'Bloc Quebecois': '#990099'
//                                }},
//                            size: {height: 200, width: 550}}
//                    }
                });
            });
        });
    </script>
    <!--<script src="../assets/js/hr.js"></script>-->
</body>
</html>
