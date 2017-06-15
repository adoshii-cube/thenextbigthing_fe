<%-- 
Document   : index
Created on : 5 May, 2017, 2:19:43 PM
Author     : adoshi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.owen.survey.QuestionType"%>
<%@page import="org.owen.survey.Question"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.owen.employee.Employee"%>
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

        <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link href="../assets/css/styles.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script>
            var jQ321 = $.noConflict();
            // Code that uses other library's $ can follow here.
        </script>
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
        <!-- Uses a header that scrolls with the text, rather than staying
          locked at the top -->
        <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
            <header class="mdl-layout__header mdl-layout__header--waterfall">
                <div class="mdl-layout__header-row">
                    <!-- Title -->
                    <a id="switchUser">
                        <span class="android-title mdl-layout-title">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <%if (isAdmin || isHR) {%>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUser">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isAdmin) {%>
                        <a href="../admin/index.jsp">
                            <li class="mdl-menu__item">Admin</li>
                        </a>
                        <%}
                            if (isHR) {%>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
                        </a>
                        <%}%>
                    </ul>
                    <%}%>
                    <!-- Add spacer, to align navigation to the right -->
                    <div class="mdl-layout-spacer"></div>
                    <!-- Navigation -->
                    <!--<div class="android-navigation-container">-->
                    <!--<nav class="mdl-navigation">-->
                    <!--<a class="mdl-navigation__link" href="">Link</a>-->
                    <!--</nav>-->
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
                    <%if (isAdmin || isHR) {%>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUserMobile">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                            <%if (isAdmin) {%>
                        <a href="../admin/index.jsp">
                            <li class="mdl-menu__item">Admin</li>
                        </a>
                        <%}
                            if (isHR) {%>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
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
                    <!--<div class="android-screen-section mdl-typography--text-center">-->
                    <!--<div class="android-wear-band-text">-->
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">

                            <div class="panelGroup" id="accordion">
                                <%
                                    Question qObj = new Question();
                                    List<Question> qList = qObj.getEmployeeQuestionList(comId, empId);
                                    if (qList.size() == 0) {
                                        response.sendRedirect("thankyou.jsp");
                                    }
                                    List<Question> mQuestionList = new ArrayList<>();
                                    List<Question> wQuestionList = new ArrayList<>();
                                    List<Question> oQuestionList = new ArrayList<>();

                                    for (int i = 0; i < qList.size(); i++) {
                                        Question q = qList.get(i);
                                        if (q.getQuestionType() == QuestionType.ME || q.getQuestionType() == QuestionType.MOOD) {
                                            mQuestionList.add(q);
                                        } else if (q.getQuestionType() == QuestionType.WE) {
                                            wQuestionList.add(q);
                                        } else {
                                            oQuestionList.add(q);
                                        }
                                    }%>
                                <input type="hidden" id="comId" value="<% out.print(comId);%>" /> 
                                <input type="hidden" id="empId" value="<% out.print(empId);%>" /> 
                                <input type="hidden" id="qListSize" value="<% out.print(qList.size());%>" />
                                <input type="hidden" id="mQListSize" value="<% out.print(mQuestionList.size());%>" />
                                <input type="hidden" id="wQListSize" value="<% out.print(wQuestionList.size());%>" />
                                <input type="hidden" id="oQListSize" value="<% out.print(oQuestionList.size());%>" />
                                <%if (mQuestionList.size() > 0) {%>
                                <div class="panel">
                                    <div class="panelHeading">

                                        <div class="panelTitle sectionMe">
                                            <a data-toggle="collapse" href="#one">
                                                <div class="sectionImage"></div>
                                                <div class="section">Section 1</div>
                                                <div class="questionCounter" id="mQuestionCounter">0/<%=mQuestionList.size()%></div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="panel-collapse collapse" id="one">
                                        <!--                                        <div class="mdl-grid">-->
                                        <%for (int i = 0; i < mQuestionList.size(); i++) {
                                                Question q = mQuestionList.get(i);
                                        %>
                                        <div class="mdl-grid">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card question"id="mQuestion-<%=q.getQuestionId()%>">
                                                <div class="questionText">
                                                    <h2><%=q.getQuestionText()%></h2>
                                                </div>
                                                <!--                                                <div class="helpText">
                                                                                                    <h5>Help text goes here</h5>
                                                                                                </div>-->
                                                <table class="meScore" id="table-<%=q.getQuestionId()%>">
                                                    <tr>
                                                        <td><label>Strongly Disagree</label></td>
                                                        <td><label></label></td>
                                                        <td><label></label></td>
                                                        <td><label></label></td>
                                                        <td><label>Strongly Agree</label></td>
                                                    </tr>
                                                    <%if (q.getQuestionType() == QuestionType.ME) {%>
                                                    <tr class="score">
                                                        <%} else if (q.getQuestionType() == QuestionType.MOOD) {%>
                                                    <tr class="mood">
                                                        <%}%>
                                                        <td>1</td>
                                                        <td>2</td>
                                                        <td>3</td>
                                                        <td>4</td>
                                                        <td>5</td>
                                                    </tr>
                                                    <tr class="radioButtons">
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me1-<%=q.getQuestionId()%>">
                                                                <input type="radio" id="me1-<%=q.getQuestionId()%>" class="mdl-radio__button" name="meOptions-<%=q.getQuestionId()%>" value="1">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me2-<%=q.getQuestionId()%>">
                                                                <input type="radio" id="me2-<%=q.getQuestionId()%>" class="mdl-radio__button" name="meOptions-<%=q.getQuestionId()%>" value="2">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me3-<%=q.getQuestionId()%>">
                                                                <input type="radio" id="me3-<%=q.getQuestionId()%>" class="mdl-radio__button" name="meOptions-<%=q.getQuestionId()%>" value="3">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me4-<%=q.getQuestionId()%>">
                                                                <input type="radio" id="me4-<%=q.getQuestionId()%>" class="mdl-radio__button" name="meOptions-<%=q.getQuestionId()%>" value="4">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me5-<%=q.getQuestionId()%>">
                                                                <input type="radio" id="me5-<%=q.getQuestionId()%>" class="mdl-radio__button" name="meOptions-<%=q.getQuestionId()%>" value="5">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <input type="hidden" id="qtype_<%= q.getQuestionId()%>" value="<% out.print(q.getQuestionType());%>" /> 
                                            </div>
                                        </div>
                                        <%}%>
                                        <!--</div>-->
                                    </div>
                                </div>
                                <%}%>
                                <!-- end of panel -->
                                <%if (wQuestionList.size() > 0) {%>
                                <div class="panel">
                                    <div class="panelHeading">
                                        <div class="panelTitle sectionWe">
                                            <a data-toggle="collapse" href="#two">
                                                <div class="sectionImage"></div>
                                                <div class="section">Section 2</div>
                                                <div class="questionCounter" id="wQuestionCounter">0/<%=wQuestionList.size()%></div>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="two" class="panel-collapse collapse">
                                        <!--<div class="mdl-grid">-->
                                        <%for (int i = 0; i < wQuestionList.size(); i++) {
                                                Question q = wQuestionList.get(i);
                                                List<Employee> mapSmartList = q.getSmartListForQuestion(comId, empId, q.getQuestionId());
                                        %>
                                        <div class="mdl-grid">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card question" id="wQuestion-<%=q.getQuestionId()%>">
                                                <div class="questionText">
                                                    <h2><%=q.getQuestionText()%></h2>
                                                </div>
                                                <!--                                                <div class="helpText">
                                                                                                    <h5>Help text goes here</h5>
                                                                                                </div>-->
                                                <div class="searchBar mdl-list">
                                                    <div class="mdl-list__item">
                                                        <span class="mdl-list__item-primary-content">
                                                            <i class="material-icons">search</i>
                                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                                                <input class="mdl-textfield__input quicksearch" type="text" id="searchField-<%=q.getQuestionId()%>">
                                                                <label class="mdl-textfield__label" for="searchField">Search</label>
                                                            </div>
                                                        </span>
                                                    </div>
                                                </div>
                                                <%if (mapSmartList.size() > 0) {%>
                                                <div class="listOfPeople" id="listOfPeople-<%=q.getQuestionId()%>">

                                                    <ul class="mdl-list" id="smartList-<%=q.getQuestionId()%>">
                                                        <%for (int incr = 0; incr < mapSmartList.size(); incr++) {
                                                                Employee employee = mapSmartList.get(incr);
                                                                if (empId == employee.getEmployeeId()) {
                                                                    continue;
                                                                }%>
                                                        <li class="mdl-list__item mdl-list__item--three-line people" id="people-<%=q.getQuestionId()%>">
                                                            <span class="mdl-list__item-primary-content">
                                                                <div class="mdl-list__item-avatar" ><%= employee.getFirstName().substring(0, 1) + employee.getLastName().substring(0, 1)%></div>
                                                                <span><%= employee.getFirstName() + " " + employee.getLastName()%></span>
                                                                <span class="mdl-list__item-text-body">
                                                                    <div class="function"><%=employee.getFunction()%></div>
                                                                    <div class="position"><%=employee.getPosition()%></div>
                                                                    <input type="hidden" name="selectedEmpId" value=<%=employee.getEmployeeId()%>>
                                                                </span>
                                                            </span>
                                                            <span class="mdl-list__item-secondary-content">
                                                                <span class="mdl-list__item-secondary-info">Like</span>
                                                                <a class="mdl-list__item-secondary-action mdl-button mdl-js-button mdl-button--icon mdl-button--mini-fab mdl-js-ripple-effect" href="#"></a>
                                                            </span>
                                                        </li>
                                                        <%}%>
                                                    </ul>
                                                </div>                                                
                                                <div class="listOfSelectedPeopleContainer">
                                                    <div class="listOfSelectedPeople" id="listOfSelectedPeople-<%=q.getQuestionId()%>"></div>
                                                    <div class="hidden" id="listOfSelectedId-<%=q.getQuestionId()%>"></div>                                               
                                                </div>
                                                <%}%>
                                            </div>
                                        </div>
                                        <%}%>
                                        <!--</div>-->
                                    </div>
                                </div>
                                <%}%>
                                <!-- end of panel -->
                                <%if (oQuestionList.size() > 0) {%>
                                <div class="panel">
                                    <div class="panelHeading">
                                        <div class="panelTitle sectionOpenText">
                                            <a data-toggle="collapse" href="#three">
                                                <div class="sectionImage"></div>
                                                <div class="section">Section 3</div>
                                                <div class="questionCounter" id="oQuestionCounter">0/<%=oQuestionList.size()%></div>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="three" class="panel-collapse collapse">
                                        <%for (int i = 0; i < oQuestionList.size(); i++) {
                                                Question q = oQuestionList.get(i);
                                        %>
                                        <div class="mdl-grid">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card question" id="oQuestion-<%=q.getQuestionId()%>">
                                                <div class="questionText">
                                                    <h2><%=q.getQuestionText()%></h2>
                                                </div>
                                                <!--                                                <div class="helpText">
                                                                                                    <h5>Some help text here</h5>
                                                                                                </div>-->
                                                <div class="mdl-textfield mdl-js-textfield openTextField">
                                                    <textarea class="mdl-textfield__input openTextResponse" type="text" rows="3" maxrows="6" id="openText-<%=q.getQuestionId()%>" ></textarea>
                                                    <label class="mdl-textfield__label" for="openText"><i>Note: Your responses are <b>confidential</b></i></label>
                                                    <input type="hidden" id="qtype_<%= q.getQuestionId()%>" value="<% out.print(q.getQuestionType());%>" /> 
                                                </div>
                                            </div>

                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                                <%}%>
                                <!-- end of panel -->
                            </div>

                        </div>
                    </div>
                    <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone submit">
                        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" disabled id="submit">
                            <i class="material-icons">check</i>
                            SUBMIT
                        </button>
                        <!--                        <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--top" for="submit">
                                                    Submit your<br>responses
                                                </div>-->
                    </div>
                </div>

        </div>
    </main>
</div>
<script src="../assets/js/material.min.js"></script>
<script src="../assets/js/employee/isotope.pkgd.min.js"></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
<script src="../assets/js/employee/employee.js"></script>
</body>
</html>
