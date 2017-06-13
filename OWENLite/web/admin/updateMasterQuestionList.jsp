<%-- 
    Document   : deleteQuestion
    Created on : 8 Jun, 2017, 3:34:39 PM
    Author     : rashmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>

<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.owen.helper.UtilHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.owen.admin.AdminHelper"%>
<%@page import="org.owen.survey.Question"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>addQuestion</title>
    </head>
    <body>
        <div class="searchBarAdmin mdl-list">
            <div class="mdl-list__item">
                <span class="mdl-list__item-primary-content">
                    <i class="material-icons">search</i>
                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <input class="mdl-textfield__input quicksearch" type="text" id="searchField">
                        <label class="mdl-textfield__label mdl-color-text--blue-grey" for="searchField">Search</label>
                    </div>
                </span>
            </div>
        </div>
        <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp" id="questionMaster">
            <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric">Relationship</th>
                    <th class="mdl-data-table__cell--non-numeric">Question</th>
                </tr>
            </thead>
            <tbody class="newQuestionsContainer">
                <%
                    AdminHelper ah = new AdminHelper();
                    List<Question> qMasterList = ah.getQuestionMasterList(comId);
                    for (int j = 1; j < qMasterList.size(); j++) {
                        Question q1 = qMasterList.get(j);
                %>
                <tr id="<%=q1.getQuestionMasterId()%>">
                    <td class="mdl-data-table__cell--non-numeric"><%=q1.getRelationshipName()%></td>
                    <td class="mdl-data-table__cell--non-numeric"><%=q1.getQuestionText()%></td>
                </tr>
                <%}%>
            </tbody>
        </table>
        <script src="../assets/js/admin/admin.js"></script>
    </body>
</html>