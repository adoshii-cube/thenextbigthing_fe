<%-- 
    Document   : fetchData
    Created on : 14 Jun, 2017, 3:16:38 PM
    Author     : rashmi
--%>

<%@page import="org.owen.hr.Edge"%>
<%@page import="org.owen.hr.Node"%>
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

    JSONObject jsonObj = new JSONObject(request.getParameter("jsonObj"));
    int functionId = UtilHelper.getIntValue(jsonObj.getString("funcId"));
    int positionId = UtilHelper.getIntValue(jsonObj.getString("posId"));
    int locationId = UtilHelper.getIntValue(jsonObj.getString("locId"));
    HrDashboardHelper hrHelper = new HrDashboardHelper();
    String nodes = hrHelper.getNodeList(comId, functionId, positionId, locationId);
    String edges = hrHelper.getEdgeList(comId, functionId, positionId, locationId);
    String indexValue = hrHelper.getRelIndexValue(comId, functionId, positionId, locationId);
    String keyPeople = hrHelper.getRelKeyPeople(comId, functionId, positionId, locationId);
    String wordCloud = hrHelper.getWordCloud(comId, functionId, positionId, locationId);
    String sentimentScore = hrHelper.getSentimentScore(comId, functionId, positionId, locationId);
    String sentimentDistribution = hrHelper.getSentimentDistribution(comId, functionId, positionId, locationId);
    String selfPerception = hrHelper.getSelfPerception(comId, functionId, positionId, locationId);
    result.put("nodes", nodes);
    result.put("edges", edges);
    result.put("indexValue", indexValue);
    result.put("keyPeople", keyPeople);
    result.put("wordCloud", wordCloud);
    result.put("sentimentScore", sentimentScore);
    result.put("sentimentDistribution", sentimentDistribution);
    result.put("selfPerception", selfPerception);
    response.setContentType("text/html");
    response.getWriter().println(result);
%>
