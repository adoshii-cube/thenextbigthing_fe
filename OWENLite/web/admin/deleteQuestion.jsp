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
<%@page import = "org.owen.survey.Question"%>
<%@page import = "java.util.Date"%>


<%
    JSONArray arr = new JSONArray(request.getParameter("qIdArray"));
    List<Integer> qIdList = new ArrayList<>();
    for (int i = 0; i < arr.length(); i++) {
        JSONObject jObj = arr.getJSONObject(i);
        qIdList.add(UtilHelper.getIntValue(jObj.getString("questionId")));
    }

    AdminHelper ah = new AdminHelper();
    boolean flag = ah.removeQuestion(comId, qIdList);
    JSONObject respJOBJ = new JSONObject();
    respJOBJ.put("status", flag);
    if (flag) {
        respJOBJ.put("message", "Successfully deleted");
        System.out.println("OWENLite :::Successfully deleted questions");
    } else {
        respJOBJ.put("message", "Deletion failed");
        System.out.println("OWENLite :::Could not delete questions");
    }
    out.print(respJOBJ.toString());
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>deleteQuestion</title>
    </head>
    <body>
    <tbody>
        <%
            List<Question> qList = ah.getVisibleQuestionList(comId);
            int count = 1;
            for (int i = 0; i < qList.size(); i++) {
                Question q = qList.get(i);
                Date startDate = q.getStartDate();
                Date endDate = q.getEndDate();
        %>
    <input type="hidden" id="startDate" value ="<%=startDate.toString()%>"/>
    <input type="hidden" id="endDate" value ="<%=endDate.toString()%>"/>                                
    <tr id="<%=q.getQuestionId()%>">
        <td><%=count++%></td>
        <td class="mdl-data-table__cell--non-numeric"><%=q.getRelationshipName()%></td>
        <td class="mdl-data-table__cell--non-numeric"><%=q.getQuestionText()%></td>
    </tr>
    <%}%>
</tbody>
</body>
</html>