<%-- 
    Document   : fetchData
    Created on : 14 Jun, 2017, 3:16:38 PM
    Author     : rashmi
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="org.owen.relationship.Relationship"%>
<%@page import="org.owen.relationship.RelationshipHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.owen.hr.HrDashboardHelper"%>
<%@page import="org.owen.helper.UtilHelper"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>

<%
    JSONObject result = new JSONObject();
    RelationshipHelper rh = new RelationshipHelper();
    List<Relationship> relList = rh.getRelationshipValues(comId);
    JSONArray metricList = new JSONArray();
    JSONArray sentimentList = new JSONArray();
    JSONArray selfPerceptionList = new JSONArray();
    for (int i = 0; i < relList.size(); i++) {
        Relationship r = relList.get(i);
        if (r.getRelationshipTypeName().equalsIgnoreCase("metric")) {
            JSONObject jObj = new JSONObject();
            jObj.put("relId", r.getRelationshipId());
            jObj.put("relName", r.getRelationshipName());
            metricList.put(jObj);
        } else if (r.getRelationshipTypeName().equalsIgnoreCase("sentiment")) {
            JSONObject jObj = new JSONObject();
            jObj.put("relId", r.getRelationshipId());
            jObj.put("relName", r.getRelationshipName());
            sentimentList.put(jObj);
        } else if (r.getRelationshipTypeName().equalsIgnoreCase("self_perception")) {
            JSONObject jObj = new JSONObject();
            jObj.put("relId", r.getRelationshipId());
            jObj.put("relName", r.getRelationshipName());
            selfPerceptionList.put(jObj);
        }
    }
    result.put("metricList", metricList.toString());
    result.put("sentimentList", sentimentList.toString());
    result.put("selfPerceptionList", selfPerceptionList.toString());

    JSONObject jsonObj = new JSONObject(request.getParameter("jsonObj"));
    int functionId = UtilHelper.getIntValue(jsonObj.getString("funcId"));
    int positionId = UtilHelper.getIntValue(jsonObj.getString("posId"));
    int locationId = UtilHelper.getIntValue(jsonObj.getString("locId"));
    HrDashboardHelper hrHelper = new HrDashboardHelper();
//    Map<String, List<?>> networkData = hrHelper.getTeamNetworkDiagram(comId, functionId, positionId, locationId);
    String indexValue = hrHelper.getRelIndexValue(comId, functionId, positionId, locationId);
    String keyPeople = hrHelper.getRelKeyPeople(comId, functionId, positionId, locationId);
    String wordCloud = hrHelper.getWordCloud(comId, functionId, positionId, locationId);
    String sentimentScore = hrHelper.getSentimentScore(comId, functionId, positionId, locationId);
    String selfPerception = hrHelper.getSelfPerception(comId, functionId, positionId, locationId);

    result.put("indexValue", indexValue);
    result.put("keyPeople", keyPeople);
    result.put("wordCloud", wordCloud);
    result.put("sentimentScore", sentimentScore);
    result.put("selfPerception", selfPerception);
    response.setContentType("text/html");
    response.getWriter().println(result);
%>
