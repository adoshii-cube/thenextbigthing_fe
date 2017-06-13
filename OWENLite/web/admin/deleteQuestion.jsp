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

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>deleteQuestion</title>
    </head>
    <body>
        <%
            JSONArray arr = new JSONArray(request.getParameter("qIdArray"));
            List<Integer> qIdList = new ArrayList<>();
            for (int i = 0; i < arr.length(); i++) {
                JSONObject jObj = arr.getJSONObject(i);
                qIdList.add(UtilHelper.getIntValue(jObj.getString("questionId")));
            }

            AdminHelper ah = new AdminHelper();
            boolean flag = ah.removeQuestion(comId, qIdList);
            if (flag) {
                System.out.println("OWENLite :::Successfully deleted questions");
            } else {
                System.out.println("OWENLite :::Could not delete questions");
            }
            List<Question> qList = ah.getVisibleQuestionList(comId);
            if (qList.size() > 0) {
        %>
        <table class="mdl-data-table mdl-js-data-table questionContainer">
            <thead>
                <tr>
                    <th>Q.No.</th>
                    <th class="mdl-data-table__cell--non-numeric">Relationship</th>
                    <th class="mdl-data-table__cell--non-numeric">Question</th>
                    <th class="mdl-data-table__cell--non-numeric">
                        <button class="mdl-button mdl-js-button mdl-button--icon" disabled id="deleteQuestions" onclick="deleteQuestions()"><i class="material-icons">delete_forever</i></button>
                    </th>
            <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--left" for="deleteQuestions">
                Delete questions
            </div>
        </tr>
    </thead>
    <tbody>
        <%
            int count = 1;
            for (int i = 0; i < qList.size(); i++) {
                Question q = qList.get(i);
                Date startDate = q.getStartDate();
                Date endDate = q.getEndDate();
        %>
    <input type="hidden" id="startDate" value ="<%=startDate.toString()%>"/>
    <input type="hidden" id="endDate" value ="<%=endDate.toString()%>"/>                                
    <tr id="<%=q.getQuestionId()%>" onclick="selectQuestionsToDelete(this)">
        <td><%=count++%></td>
        <td class="mdl-data-table__cell--non-numeric"><%=q.getRelationshipName()%></td>
        <td class="mdl-data-table__cell--non-numeric"><%=q.getQuestionText()%></td>
    </tr>
    <%}
    } else {%>
    <div class="emptyState">
        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone image"></div>
        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone messageMainText">
            <h4>Ouhh..it's empty in here</h4>
        </div>
        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone messageSubText">
            <p>You do not have any active questions<br>
                Add some questions, and start a survey.<br>
                Click on the '+' button below to begin.
            </p>
        </div>
    </div>    
    <%}%>
</tbody>
</table>
</body>
</html>