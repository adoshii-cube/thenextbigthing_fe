<%-- 
    Document   : index
    Created on : 12 May, 2017, 4:36:45 PM
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
        <link href="../assets/css/dc.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/dc-tooltip-mixin.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

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
        <!--mdl-layout__header--scroll-->
        <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
            <header class="mdl-layout__header mdl-layout__header--waterfall mdl-color--orange-500">
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
                        <a class="mdl-navigation__link" href="#sentiment">Sentiment</a>
                        <a class="mdl-navigation__link" href="#selfPerception">Self Perception</a>
                        <a class="mdl-navigation__link" href="explore.jsp">Explore</a>
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
                    <div class="android-card-container mdl-grid filterPanelParent">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-shadow--3dp filterPanel">                            
                            <!--<form >-->
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
                                <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-color--orange-A700 mdl-color-text--white" onclick="go()">
                                    GO
                                </button>
                            <!--</form>-->
                        </div>
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp weSection">
                            <a id="relationship"></a>
                            <div class="mdl-card__title font2x">RELATIONSHIP</div>
                            <div class="mdl-grid sectionGridLayoutWidth">
                                <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                    <div id="dropdown_relationship"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                    <div class="responseCountContainer">Responses:<div class="responseCount" id="weSectionResponses"></div></div>
                                </div>
                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Network Diagram</div>
                                    <div class="mdl-card__supporting-text" id="weSectionNetwork"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Index Value</div>
                                    <div class="mdl-card__supporting-text" id="weSectionIndex"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">List of Key People</div>
                                    <div class="mdl-card__supporting-text">
                                        <table class="mdl-data-table mdl-js-data-table" id="weSectionListOfPeople">
                                            <thead>
                                                <tr>
                                                    <th class="mdl-data-table__cell--non-numeric">People</th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                                <div class="mdl-cell mdl-cell--12-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Understanding the charts</div>
                                    <div class="mdl-card__supporting-text " >
                                        <table class="mdl-data-table mdl-js-data-table" id="weSectionExplanation">
                                            <thead>
                                                <tr>
                                                    <th class="mdl-data-table__cell--non-numeric">Explanation</th>
                                                    <th class="mdl-data-table__cell--non-numeric">Action</th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                                <!--                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                                    <div class="mdl-card__title weSectionAction">ACTION</div>
                                                                    <div class="mdl-card__supporting-text">
                                                                        <ul>
                                                                            <li>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</li>
                                                                            <li>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</li>
                                                                            <li>Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.</li>
                                                                            <li>Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</li>
                                                                        </ul>
                                                                    </div>
                                                                </div>-->
                            </div>
                        </div>
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp openText">
                            <a id="sentiment"></a>
                            <div class="mdl-card__title font2x">Sentiment</div>
                            <div class="mdl-grid sectionGridLayoutWidth">
                                <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                    <div id="dropdown_theme"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                    <div class="responseCountContainer">Responses:<div class="responseCount" id="openTextResponses"></div></div>
                                </div>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Sentiment Image</div>
                                    <div class="mdl-card__supporting-text openTextImage" id="openTextImage"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--8-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Word Cloud</div>
                                    <div class="mdl-card__supporting-text openTextWordCloud" id="openTextWordCloud">

                                    </div>
                                </div>
                                <!--                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                                                    <div class="mdl-card__title">Word Association (Bigrams)</div>
                                                                    <div class="mdl-card__supporting-text openTextTable">
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
                                <div class="mdl-cell mdl-cell--12-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">EXPLANATION</div>
                                    <!--<div class="mdl-card__supporting-text openTextExplanation">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</div>-->
                                    <div class="mdl-card__supporting-text">
                                        <table class="mdl-data-table mdl-js-data-table" id="openTextExplanation">
                                            <thead>
                                                <tr>
                                                    <th class="mdl-data-table__cell--non-numeric">Explanation</th>
                                                    <th class="mdl-data-table__cell--non-numeric">Action</th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                                <!--                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                                    <div class="mdl-card__title">ACTION</div>
                                                                    <div class="mdl-card__supporting-text openTextAction">
                                                                        <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                                                                        <p>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</p>
                                                                        <p>Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.</p>
                                                                        <p>Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>
                                                                    </div>
                                                                </div>-->
                            </div>
                        </div>
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card mdl-shadow--3dp meSection">
                            <a id="selfPerception"></a>
                            <div class="mdl-card__title">SELF PERCEPTION</div>
                            <div class="mdl-grid sectionGridLayoutWidth">
                                <div class="mdl-cell mdl-cell--8-col mdl-cell--6-col-tablet mdl-cell--2-col-phone">
                                    <div id="dropdown_component"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--4-col mdl-cell--2-col-tablet mdl-cell--2-col-phone responseCountContainerParent">
                                    <div class="responseCountContainer">Responses:<div class="responseCount" id="meSectionResponses"></div></div>
                                </div>
                                <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">Distribution of Scores</div>
                                    <div class="mdl-card__supporting-text meSectionDistribution"></div>
                                </div>
                                <div class="mdl-cell mdl-cell--12-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                    <div class="mdl-card__title">EXPLANATION</div>
                                    <!--<div class="mdl-card__supporting-text meSectionExplanation">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</div>-->
                                    <div class="mdl-card__supporting-text ">
                                        <table class="mdl-data-table mdl-js-data-table" id="meSectionExplanation">
                                            <thead>
                                                <tr>
                                                    <th class="mdl-data-table__cell--non-numeric">Explanation</th>
                                                    <th class="mdl-data-table__cell--non-numeric">Action</th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                                <!--                                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet mdl-cell--4-col-phone mdl-card">
                                                                    <div class="mdl-card__title">ACTION</div>
                                                                    <div class="mdl-card__supporting-text meSectionAction">
                                                                        <ol>
                                                                            <li>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</li>
                                                                            <li>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.</li>
                                                                            <li>Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.</li>
                                                                            <li>Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</li>
                                                                        </ol>
                                                                    </div>
                                                                </div>-->
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="../assets/js/material.min.js"></script>
        <script src="../assets/js/mdl-selectfield.min.js"></script>
        <script src="../assets/js/hr/index/stickyfill.min.js"></script>
        <script src="../assets/js/hr/index/vis.min.js"></script>

        <!--Wordcloud + dcjs bar chart + dropdown-->
        <script src="../assets/js/hr/index/d3.min.js"></script>
        <script src="../assets/js/hr/index/wordcloud/index.js"></script>
        <script src="../assets/js/hr/index/crossfilter.min.js"></script>
        <script src="../assets/js/hr/index/dc.min.js"></script>

        <!--Wordcloud-->
        <script src="../assets/js/hr/index/wordcloud/d3.layout.cloud.js"></script>
        <script src="../assets/js/hr/index/wordcloud/dc-wordcloud.js" type="text/javascript"></script>

        <!--Introduce modularity in here-->
        <script src="../assets/js/hr/index/hr.js"></script>

    </body>
</html>
