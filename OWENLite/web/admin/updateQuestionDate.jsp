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
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>


<%
    JSONObject jsonObj = new JSONObject(request.getParameter("jsonObj"));
    String startDateStr = jsonObj.getString("startDate");
    String endDateStr = jsonObj.getString("endDate");
    Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr);
    Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);

    AdminHelper ah = new AdminHelper();
    boolean flag = ah.updateQuestionDate(comId, startDate, endDate);
    JSONObject respJOBJ = new JSONObject();
    respJOBJ.put("status", flag);
    if (flag) {
        respJOBJ.put("message", "Successfully added");
        System.out.println("OWENLite :::Successfully added questions");
    } else {
        respJOBJ.put("message", "Deletion failed");
        System.out.println("OWENLite :::Could not added questions");
    }
    out.print(respJOBJ.toString());
%>