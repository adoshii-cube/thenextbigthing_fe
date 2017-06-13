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
            JSONArray arr = new JSONArray(request.getParameter("qIdArray"));
            String startDateStr = "", endDateStr = "";
            List<Integer> qIdList = new ArrayList<>();
            for (int i = 0; i < arr.length(); i++) {
                JSONObject jObj = arr.getJSONObject(i);
                qIdList.add(UtilHelper.getIntValue(jObj.getString("questionId")));
                startDateStr = jObj.getString("startDate");
                endDateStr = jObj.getString("endDate");
            }
            Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr);
            Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);

            AdminHelper ah = new AdminHelper();
            boolean flag = ah.addQuestion(comId, qIdList, startDate, endDate);

            if (flag) {
                System.out.println("OWENLite :::Successfully added questions");
            } else {
                System.out.println("OWENLite :::Could not add questions");
            }
            List<Question> qList = ah.getVisibleQuestionList(comId);
            int count = 1;
            for (int i = 0; i < qList.size(); i++) {
                Question q = qList.get(i);
        %>
    <input type="hidden" id="startDate" value ="<%=q.getStartDate().toString()%>"/>
    <input type="hidden" id="endDate" value ="<%=q.getEndDate().toString()%>"/>                                
    <tr id="<%=q.getQuestionId()%>" onclick="selectQuestionsToDelete(this)">
        <td><%=count++%></td>
        <td class="mdl-data-table__cell--non-numeric"><%=q.getRelationshipName()%></td>
        <td class="mdl-data-table__cell--non-numeric"><%=q.getQuestionText()%></td>
    </tr>
    <%}%>
</tbody>
</table>
</body>
</html>