<%-- 
    Document   : index
    Created on : 26 Jun, 2017, 11:59:19 AM
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
        <!--<link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link href="../assets/css/hr.css" rel="stylesheet" type="text/css">      

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="../assets/js/hr/index/jquery.slidereveal.min.js"></script>

        <script src="../assets/js/hr/index/cytoscape.min.js"></script>

        <script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.js"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.rawgit.com/cytoscape/cytoscape.js-qtip/2.7.0/cytoscape-qtip.js"></script>

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
                        <a class="mdl-navigation__link" href="index.jsp">Dashboard</a>
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
            <button class="mdl-button mdl-js-button mdl-button--icon" id="trigger">
                <i class="material-icons">menu</i>
            </button>
            <main class="android-content mdl-layout__content">
                <div id="slider">
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                            <select id="dropdown_function" name="function" class="mdl-selectfield__select" required>
                                <%
                                    FilterHelper fh = new FilterHelper();
                                    Filter function = fh.getFilterValues(comId, "Function");
                                    Map<Integer, String> filterValues = function.getFilterValues();
                                    for (Map.Entry<Integer, String> entry : filterValues.entrySet()) {
                                        int id = entry.getKey();
                                        String value = entry.getValue();
                                %>
                                <option value="<%=id%>"><%=value%></option>
                                <%}%>
                            </select>
                            <label class="mdl-selectfield__label" for="myselect">FUNCTION</label>
                            <span class="mdl-selectfield__error">Please select a function</span>
                        </div>
                        <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                            <select id="dropdown_position" name="position" class="mdl-selectfield__select" required>
                                <%
                                    Filter position = fh.getFilterValues(comId, "Position");
                                    Map<Integer, String> positionValues = position.getFilterValues();
                                    for (Map.Entry<Integer, String> entry : positionValues.entrySet()) {
                                        int id = entry.getKey();
                                        String value = entry.getValue();
                                %>
                                <option value="<%=id%>"><%=value%></option>
                                <%}%>
                            </select>
                            <label class="mdl-selectfield__label" for="myselect">POSITION</label>
                            <span class="mdl-selectfield__error">Please select a position</span>
                        </div>
                        <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                            <select id="dropdown_location" name="location" class="mdl-selectfield__select" required>
                                <%
                                    Filter location = fh.getFilterValues(comId, "Location");
                                    Map<Integer, String> locationValues = location.getFilterValues();
                                    for (Map.Entry<Integer, String> entry : locationValues.entrySet()) {
                                        int id = entry.getKey();
                                        String value = entry.getValue();
                                %>
                                <option value="<%=id%>"><%=value%></option>
                                <%}%>
                            </select>
                            <label class="mdl-selectfield__label" for="myselect">LOCATION</label>
                            <span class="mdl-selectfield__error">Please select a location</span>
                        </div>
                        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" onclick="go()">
                            GO
                        </button>
                    </div>
                </div>
                <div class="hr-page-content">
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                            <div class="mdl-tabs mdl-js-tabs mdl-js-ripple-effect">
                                <div class="mdl-tabs__tab-bar">
                                    <a href="#panelRelationship" class="mdl-tabs__tab is-active">Relationship</a>
                                    <a href="#panelSentiment" class="mdl-tabs__tab">Sentiment</a>
                                    <a href="#panelComponent" class="mdl-tabs__tab">Component</a>
                                </div>

                                <div class="mdl-tabs__panel is-active" id="panelRelationship">
                                    <div class="mdl-grid sectionGridLayoutWidth">
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                <select id="dropdown_relationship" name="relationshipQuestion" class="mdl-selectfield__select" required>
                                                    <option value="1">Option 1</option>
                                                    <option value="2">Option 2</option>
                                                    <option value="3">Option 3</option>
                                                </select>
                                                <label class="mdl-selectfield__label" for="relationshipQuestion">Relationship Type</label>
                                                <span class="mdl-selectfield__error">Please select a relationship type</span>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                            <div class="responseCountContainer">Responses:&nbsp;<div class="responseCount" id="relationshipResponses">243</div></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Network Diagram</div>
                                            <div class="mdl-card__supporting-text" id="relationshipNetwork"></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Index Value</div>
                                            <div class="mdl-card__supporting-text" id="relationshipIndex">4.32</div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">List of Key People</div>
                                            <div class="mdl-card__supporting-text">
                                                <table class="mdl-data-table mdl-js-data-table" id="relationshipListOfPeople">
                                                    <thead>
                                                        <tr>
                                                            <th class="mdl-data-table__cell--non-numeric">People</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr id="template">
                                                            <td class="mdl-data-table__cell--non-numeric">People 1</td>
                                                        </tr>
                                                        <tr id="template">
                                                            <td class="mdl-data-table__cell--non-numeric">People 2</td>
                                                        </tr>
                                                        <tr id="template">
                                                            <td class="mdl-data-table__cell--non-numeric">People 3</td>
                                                        </tr>
                                                        <tr id="template">
                                                            <td class="mdl-data-table__cell--non-numeric">People 4</td>
                                                        </tr>
                                                        <tr id="template">
                                                            <td class="mdl-data-table__cell--non-numeric">People 5</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title relationshipAction">Action</div>
                                            <div class="mdl-card__supporting-text">
                                                <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title relationshipAction">Explanation</div>
                                            <div class="mdl-card__supporting-text">
                                                <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mdl-tabs__panel" id="panelSentiment">
                                    <div class="mdl-grid sectionGridLayoutWidth">
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                <select id="dropdown_sentiment" name="sentimentQuestion" class="mdl-selectfield__select" required>
                                                    <option value="1">Option 1</option>
                                                    <option value="2">Option 2</option>
                                                    <option value="3">Option 3</option>
                                                </select>
                                                <label class="mdl-selectfield__label" for="sentimentQuestion">Sentiment Type</label>
                                                <span class="mdl-selectfield__error">Please select a sentiment type</span>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                            <div class="responseCountContainer">Responses:&nbsp;<div class="responseCount" id="sentimentResponses">432</div></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Sentiment Gauge</div>
                                            <div class="mdl-card__supporting-text" id="sentimentGauge"></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Sentiment Distribution</div>
                                            <div class="mdl-card__supporting-text" id="sentimentDistribution"></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--12-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Word Cloud</div>
                                            <div class="mdl-card__supporting-text sentimentWordCloud" id="sentimentWordCloud">
                                            </div>
                                        </div>
                                        <!--                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                                            <div class="mdl-card__title">Word Association (Bigrams)</div>
                                                                            <div class="mdl-card__supporting-text sentimentTable">
                                                                                <table class="mdl-data-table mdl-js-data-table">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <th class="mdl-data-table__cell--non-numeric">Word</th>
                                                                                            <th class="mdl-data-table__cell--non-numeric">Bigram Pair</th>
                                                                                            <th>Value</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric" rowspan="5">Word 1</td>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 1 word 1</td>
                                                                                            <td>70</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 2 word 1</td>
                                                                                            <td>60</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 3 word 1</td>
                                                                                            <td>50</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 4 word 1</td>
                                                                                            <td>40</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 5 word 1</td>
                                                                                            <td>30</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric" rowspan="5">Word 2</td>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 1 word 2</td>
                                                                                            <td>70</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 2 word 2</td>
                                                                                            <td>60</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 3 word 2</td>
                                                                                            <td>50</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 4 word 2</td>
                                                                                            <td>40</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td class="mdl-data-table__cell--non-numeric">Bigram 5 word 2</td>
                                                                                            <td>30</td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </div>-->
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Action</div>
                                            <div class="mdl-card__supporting-text sentimentAction">
                                                <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Explanation</div>
                                            <div class="mdl-card__supporting-text sentimentExplanation">
                                                <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mdl-tabs__panel" id="panelComponent">
                                    <div class="mdl-grid sectionGridLayoutWidth">
                                        <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                            <div class="mdl-selectfield mdl-js-selectfield  mdl-selectfield--floating-label">
                                                <select id="dropdown_component" name="componentQuestion" class="mdl-selectfield__select" required>
                                                    <option value="1">Option 1</option>
                                                    <option value="2">Option 2</option>
                                                    <option value="3">Option 3</option>
                                                </select>
                                                <label class="mdl-selectfield__label" for="componentQuestion">Component Type</label>
                                                <span class="mdl-selectfield__error">Please select a Component type</span>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                            <div class="responseCountContainer">Responses:&nbsp;<div class="responseCount" id="componentResponses">342</div></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Distribution of Scores</div>
                                            <div class="mdl-card__supporting-text " id="componentDistribution"></div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Action</div>
                                            <div class="mdl-card__supporting-text componentAction">
                                                <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
                                            </div>
                                        </div>
                                        <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                            <div class="mdl-card__title">Explanation</div>
                                            <div class="mdl-card__supporting-text componentExplanation">
                                                <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
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
        <script src="../assets/js/hr/index/hr.js"></script>
    </body>
</html>
