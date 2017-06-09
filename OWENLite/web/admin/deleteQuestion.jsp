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