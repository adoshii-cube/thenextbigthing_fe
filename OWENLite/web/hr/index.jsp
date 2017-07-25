<%-- 
    Document   : index
    Created on : 26 Jun, 2017, 11:59:19 AM
    Author     : adoshi
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="java.lang.String"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.owen.filter.FilterHelper"%>
<%@page import="org.owen.filter.Filter"%>
<%@page import="org.owen.relationship.RelationshipHelper"%>
<%@page import="org.owen.relationship.Relationship"%>
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
        <link href="../assets/css/mdl-selectfield.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link href="../assets/css/hr.css" rel="stylesheet" type="text/css">      

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="../assets/js/hr/index/jquery.slidereveal.min.js"></script>

        <script src="../assets/js/hr/index/cytoscape.min.js"></script>
        <!--<script src="../assets/js/hr/index/ogma.min.js"></script>-->

        <script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.js"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.rawgit.com/cytoscape/cytoscape.js-qtip/2.7.0/cytoscape-qtip.js"></script>

        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/highcharts-more.js"></script>
        <script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>

        <link rel='shortcut icon' type='image/x-icon' href='../assets/images/OWEN_Favicon.ico'/>

        <!--Calling here for loader-->
        <script src="../assets/js/material.min.js"></script>

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
            <header class="mdl-layout__header mdl-layout__header--waterfall">
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
                        <a class="mdl-navigation__link selected" href="">Dashboard</a>
                        <a class="mdl-navigation__link" href="explore.jsp">Explore</a>
                    </nav>
                    <button id="switch-role-menu"
                            class="mdl-button mdl-js-button mdl-button--icon">
                        <i class="material-icons">account_circle</i>
                    </button>
                    <%if (isAdmin || isEmployee) {%>
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
            <!--            <button class="mdl-button mdl-js-button mdl-button--icon mdl-js-ripple-effect" id="trigger">
                            <i class="material-icons">menu</i>
                        </button>-->
            <input type="hidden" id="comId" value="<% out.print(comId);%>" /> 
            <input type="hidden" id="empId" value="<% out.print(empId);%>" /> 
            <div id="slider">
                <button class="mdl-button mdl-js-button mdl-button--icon mdl-js-ripple-effect" id="trigger2">
                    <i class="material-icons">keyboard_arrow_right</i>
                </button>
                <div class="android-card-container mdl-grid">
                    <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                        <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                            <select id="dropdown_function" name="function" class="mdl-selectfield__select" required>
                                <%
                                    FilterHelper fh = new FilterHelper();
                                    Filter function = fh.getFilterValues(comId, "Function");
                                    Map<Integer, String> functionValues = function.getFilterValues();
                                    JSONObject fJsonObj = new JSONObject();
                                    for (Map.Entry<Integer, String> entry : functionValues.entrySet()) {
                                        int id = entry.getKey();
                                        String value = entry.getValue();
                                        if (value != "All") {
                                            fJsonObj.put(String.valueOf(id), value);
                                        }
                                %>
                                <option value="<%=id%>"><%=value%></option>
                                <%}%>                            </select>
                            <input hidden="text" id="functionValues" value='<%=fJsonObj.toString()%>'>
                            <label class="mdl-selectfield__label" for="myselect">FUNCTION</label>
                            <span class="mdl-selectfield__error">Please select a function</span>
                        </div>
                    </div>
                    <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                        <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                            <select id="dropdown_position" name="position" class="mdl-selectfield__select" required>
                                <%
                                    Filter position = fh.getFilterValues(comId, "Position");
                                    Map<Integer, String> positionValues = position.getFilterValues();
                                    JSONObject pJsonObj = new JSONObject();
                                    for (Map.Entry<Integer, String> entry : positionValues.entrySet()) {
                                        int id = entry.getKey();
                                        String value = entry.getValue();
                                        if (value != "All") {
                                            pJsonObj.put(String.valueOf(id), value);
                                        }
                                %>
                                <option value="<%=id%>"><%=value%></option>
                                <%}%>
                            </select>
                            <input hidden="text" id="positionValues" value='<%=pJsonObj.toString()%>'>
                            <label class="mdl-selectfield__label" for="myselect">POSITION</label>
                            <span class="mdl-selectfield__error">Please select a position</span>
                        </div>
                    </div>
                    <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                        <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                            <select id="dropdown_location" name="location" class="mdl-selectfield__select" required>
                                <%
                                    Filter location = fh.getFilterValues(comId, "Location");
                                    Map<Integer, String> locationValues = location.getFilterValues();
                                    JSONObject lJsonObj = new JSONObject();
                                    for (Map.Entry<Integer, String> entry : locationValues.entrySet()) {
                                        int id = entry.getKey();
                                        String value = entry.getValue();
                                        if (value != "All") {
                                            lJsonObj.put(String.valueOf(id), value);
                                        }
                                %>
                                <option value="<%=id%>"><%=value%></option>
                                <%}%>
                            </select>
                            <input hidden="text" id="locationValues" value='<%=lJsonObj.toString()%>'>
                            <label class="mdl-selectfield__label" for="myselect">LOCATION</label>
                            <span class="mdl-selectfield__error">Please select a location</span>
                        </div>
                    </div>
                    <!--<div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">-->
                    <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" id="goFilterDataButton">
                        GO
                    </button>
                    <!--</div>-->
                </div>
            </div>
            <main class="android-content mdl-layout__content">
                <div class="hr-page-content">
                    <div class="android-card-container mdl-grid pageLoaderContainer">
                        <div class="mdl-layout-spacer"></div>
                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone">
                            <div class="mdl-spinner mdl-js-spinner is-active"></div>
                        </div>                        
                        <div class="mdl-layout-spacer"></div>
                    </div>
                    <!--Empty State Msg GLOBAL start-->
                    <div class="android-card-container mdl-grid emptyDashboard">
                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                <h2>Dashboard under construction</h2>
                            </div>
                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                <p>
                                    Your dashboard will be ready as soon as you go live with a survey.
                                    <%if (isAdmin) {%>
                                    Go to the <a href="../admin/questions.jsp">admin</a> page to start your first survey now.
                                    <%}%>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!--Empty State Msg GLOBAL end-->

                    <div class="android-card-container mdl-grid dashboard">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                            <div class="mdl-tabs mdl-js-tabs mdl-js-ripple-effect">
                                <div class="mdl-tabs__tab-bar">
                                    <a href="#panelRelationship" class="mdl-tabs__tab is-active" id="panelRelationshipLabel">Relationship</a>
                                    <a href="#panelSentiment" class="mdl-tabs__tab  mdl-tabs-panel-disabled" id="panelSentimentLabel">Sentiment</a>
                                    <a href="#panelComponent" class="mdl-tabs__tab  mdl-tabs-panel-disabled" id="panelComponentLabel">Component</a>
                                </div>

                                <%
                                    RelationshipHelper rh = new RelationshipHelper();
                                    Map<Integer, List<Relationship>> relMap = rh.getRelationshipValues(comId);
                                %>

                                <div class="mdl-tabs__panel is-active" id="panelRelationship">

                                    <!--Empty State Msg PANEL RELATIONSHIP start-->
                                    <div class="android-card-container mdl-grid emptyPanel" id="relationshipPanelEmptyState">
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <h2>Awaiting survey responses</h2>
                                            </div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                                <p>
                                                    Looks like people are yet to respond to the survey.
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Empty State Msg PANEL RELATIONSHIP end-->

                                    <div class="mdl-grid sectionGridLayoutWidth" id="relationshipPanel">
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                <select id="dropdown_relationship" name="relationshipQuestion" class="mdl-selectfield__select" required>
                                                    <%
                                                        List<Relationship> list = relMap.get(1);
                                                        for (int i = 0; i < list.size(); i++) {
                                                            Relationship r = list.get(i);
                                                    %>
                                                    <option value="<%=r.getRelationshipId()%>"><%=r.getRelationshipName()%></option>
                                                    <%}%>
                                                </select>
                                                <label class="mdl-selectfield__label" for="relationshipQuestion">Relationship Type</label>
                                                <span class="mdl-selectfield__error">Please select a relationship type</span>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                            <div class="responseCountContainer">Responses:&nbsp;<div class="responseCount" id="relationshipResponses">0</div></div>
                                        </div>

                                        <!--Empty State Msg CHARTS RELATIONSHIP Start-->
                                        <div class="android-card-container mdl-grid emptyCharts" id="relationshipChartsEmptyState">
                                            <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                    <h2>No questions set</h2>
                                                </div>
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                                    <p>
                                                        You have not set any questions in your survey 
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <!--Empty State Msg CHARTS RELATIONSHIP End-->
                                        <div id="relationshipChartsLoader" class="mdl-progress mdl-js-progress mdl-progress__indeterminate"></div>
                                        <div class="chartsContainer mdl-grid" id="relationshipCharts">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Network Diagram</div>
                                                <button class="mdl-button mdl-js-button mdl-button--icon" id="resizeNetwork">
                                                    <!--<i class="material-icons">mood</i>-->
                                                    <img alt="resize Network Chart" src="../assets/images/arrow-expand.png">
                                                </button>
                                                <div class="mdl-card__supporting-text mdl-grid percent98width">
                                                    <div class="mdl-cell mdl-cell--9-col mdl-cell--8-col-tablet mdl-cell--4-col-phone"  id="relationshipNetwork"></div>
                                                    <div class="mdl-cell mdl-cell--3-col mdl-cell--8-col-tablet mdl-cell--4-col-phone" id="legendColorByContainer">
                                                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone" id="colorByContainer">
                                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                                <select id="dropdown_relationship_color" name="relationshipColor" class="mdl-selectfield__select" required>
                                                                    <option value="1">Function</option>
                                                                    <option value="2">Position</option>
                                                                    <option value="3">Location</option>
                                                                </select>
                                                                <label class="mdl-selectfield__label" for="relationshipColor">Color by</label>
                                                                <span class="mdl-selectfield__error">Please select an option</span>
                                                            </div>
                                                        </div>
                                                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone" id="legendContainer">
                                                            <ul class="legend"></ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--<div class="mdl-card__actions" id="relationshipNetworkLegend">-->

                                                <!--</div>-->
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Index Value</div>
                                                <div class="mdl-card__supporting-text" id="relationshipIndex"></div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">List of Key People</div>
                                                <div class="mdl-card__supporting-text">
                                                    <table class="mdl-data-table mdl-js-data-table" id="relationshipListOfPeople">
                                                        <!--<thead>
                                                                <tr>
                                                                    <th class="mdl-data-table__cell--non-numeric">People</th>
                                                                </tr>
                                                            </thead>-->
                                                        <tbody>
                                                            <tr id="template">
                                                                <td class="mdl-data-table__cell--non-numeric people"></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title relationshipAction">Action</div>
                                                <div class="mdl-card__supporting-text">
                                                    <p id="relationshipAction"></p>
                                                </div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title relationshipExplanation">Explanation</div>
                                                <div class="mdl-card__supporting-text">
                                                    <p id="relationshipExplanation"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mdl-tabs__panel" id="panelSentiment">

                                    <!--Empty State Msg PANEL SENTIMENT start-->
                                    <div class="android-card-container mdl-grid emptyPanel" id="sentimentPanelEmptyState">
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <h2>Awaiting survey responses</h2>
                                            </div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                                <p>
                                                    Looks like people are yet to respond to the survey.
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Empty State Msg PANEL SENTIMENT end-->

                                    <div class="mdl-grid sectionGridLayoutWidth" id="sentimentPanel">
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                <select id="dropdown_sentiment" name="sentimentQuestion" class="mdl-selectfield__select" required>
                                                    <%
                                                        List<Relationship> list2 = relMap.get(2);
                                                        for (int i = 0; i < list2.size(); i++) {
                                                            Relationship r = list2.get(i);
                                                    %>
                                                    <option value="<%=r.getRelationshipId()%>"><%=r.getRelationshipName()%></option>
                                                    <%}%>
                                                </select>
                                                <label class="mdl-selectfield__label" for="sentimentQuestion">Sentiment Type</label>
                                                <span class="mdl-selectfield__error">Please select a sentiment type</span>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                            <div class="responseCountContainer">Responses:&nbsp;<div class="responseCount" id="sentimentResponses">432</div></div>
                                        </div>


                                        <!--Empty State Msg CHARTS SENTIMENT Start-->
                                        <div class="android-card-container mdl-grid emptyCharts" id="sentimentChartsEmptyState">
                                            <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                    <h2>No questions set</h2>
                                                </div>
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                                    <p>
                                                        You have not set any questions in your survey 
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <!--Empty State Msg CHARTS SENTIMENT End-->
                                        <div id="sentimentChartsLoader" class="mdl-progress mdl-js-progress mdl-progress__indeterminate"></div>
                                        <div class="chartsContainer mdl-grid" id="sentimentCharts">
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Sentiment Gauge</div>
                                                <div class="mdl-card__supporting-text" id="sentimentGauge"></div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Sentiment Distribution</div>
                                                <div class="mdl-card__supporting-text" id="sentimentDistribution"></div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Word Cloud</div>
                                                <div class="mdl-card__supporting-text sentimentWordCloud">
                                                    <canvas id="sentimentWordCloud" width="760" height="500" style="width: 380px; height: 250px"></canvas>
                                                </div>
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
                                                            <tr id="temp">
                                                                <td class="mdl-data-table__cell--non-numeric word"></td>
                                                                <td class="mdl-data-table__cell--non-numeric association"></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Action</div>
                                                <div class="mdl-card__supporting-text sentimentAction">
                                                    <p id="sentimentAction"></p>
                                                </div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Explanation</div>
                                                <div class="mdl-card__supporting-text sentimentExplanation">
                                                    <p id="sentimentExplanation"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mdl-tabs__panel" id="panelComponent">

                                    <!--Empty State Msg PANEL COMPONENT start-->
                                    <div class="android-card-container mdl-grid emptyPanel" id="componentPanelEmptyState">
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <h2>Awaiting survey responses</h2>
                                            </div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                                <p>
                                                    Looks like people are yet to respond to the survey.
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Empty State Msg PANEL COMPONENT end-->

                                    <div class="mdl-grid sectionGridLayoutWidth" id="componentPanel">
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                <select id="dropdown_component" name="componentQuestion" class="mdl-selectfield__select" required>
                                                    <%
                                                        List<Relationship> list3 = relMap.get(3);
                                                        for (int i = 0; i < list3.size(); i++) {
                                                            Relationship r = list3.get(i);
                                                    %>
                                                    <option value="<%=r.getRelationshipId()%>"><%=r.getRelationshipName()%></option>
                                                    <%}%>
                                                </select>
                                                <label class="mdl-selectfield__label" for="componentQuestion">Component Type</label>
                                                <span class="mdl-selectfield__error">Please select a Component type</span>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                            <div class="responseCountContainer">Responses:&nbsp;<div class="responseCount" id="componentResponses">0</div></div>
                                        </div>

                                        <!--Empty State Msg CHARTS COMPONENT Start-->
                                        <div class="android-card-container mdl-grid emptyCharts" id="componentChartsEmptyState">
                                            <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card image"></div>
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                    <h2>No questions set</h2>
                                                </div>
                                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card message">
                                                    <p>
                                                        You have not set any questions in your survey 
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <!--Empty State Msg CHARTS COMPONENT End-->
                                        <div id="componentChartsLoader" class="mdl-progress mdl-js-progress mdl-progress__indeterminate"></div>
                                        <div class="chartsContainer mdl-grid" id="componentCharts">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Distribution of Scores</div>
                                                <div class="mdl-card__supporting-text " id="componentDistribution"></div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Action</div>
                                                <div class="mdl-card__supporting-text componentAction">
                                                    <p id="componentAction"></p>
                                                </div>
                                            </div>
                                            <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                <div class="mdl-card__title">Explanation</div>
                                                <div class="mdl-card__supporting-text componentExplanation">
                                                    <p id="componentExplanation"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="../assets/js/material.min.js"></script>
        <script src="../assets/js/mdl-selectfield.min.js"></script>
        <script src="../assets/js/hr/index/wordcloud/wordcloud2.js"></script>
        <script src="../assets/js/hr/index/hr.js"></script>
    </body>
</html>
