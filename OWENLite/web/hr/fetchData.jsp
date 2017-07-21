<%-- 
    Document   : fetchData
    Created on : 14 Jun, 2017, 3:16:38 PM
    Author     : rashmi
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.nio.file.StandardOpenOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.owen.hr.HrDashboardHelper"%>
<%@page import="org.owen.helper.UtilHelper"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>

<%    JSONObject result = new JSONObject();
    boolean relationshipTab = false;
    boolean sentimentTab = false;
    boolean componentTab = false;
    JSONObject jsonObj = new JSONObject(request.getParameter("jsonObj"));
    int functionId = UtilHelper.getIntValue(jsonObj.getString("funcId"));
    int positionId = UtilHelper.getIntValue(jsonObj.getString("posId"));
    int locationId = UtilHelper.getIntValue(jsonObj.getString("locId"));
    HrDashboardHelper hrHelper = new HrDashboardHelper();
    String nodes = hrHelper.getNodeList(comId, functionId, positionId, locationId);
    String edges = hrHelper.getEdgeList(comId, functionId, positionId, locationId);

    // Fetch API Code
//    String nodesEdgesData = hrHelper.getNodeEdgeData(comId, functionId, positionId, locationId);
//    File f = new File(jsonDataFilePath);
//    FileWriter filewriter = new FileWriter(f, false);
//    filewriter.write((""));
//    filewriter.append(nodesEdgesData); // Pass json object.
//    filewriter.flush();
//    filewriter.close();
    String indexValue = hrHelper.getRelIndexValue(comId, functionId, positionId, locationId);
    String keyPeople = hrHelper.getRelKeyPeople(comId, functionId, positionId, locationId);
    String wordCloud = hrHelper.getWordCloud(comId, functionId, positionId, locationId);
    String sentimentScore = hrHelper.getSentimentScore(comId, functionId, positionId, locationId);
    String sentimentDistribution = hrHelper.getSentimentDistribution(comId, functionId, positionId, locationId);
    String selfPerception = hrHelper.getSelfPerception(comId, functionId, positionId, locationId);
//    result.put("nodesEdgesData", nodesEdgesData);

    result.put("nodes", nodes);
    result.put("edges", edges);
    result.put("indexValue", indexValue);
    result.put("keyPeople", keyPeople);
    if (!nodes.isEmpty() && !edges.isEmpty() && !indexValue.isEmpty() && !keyPeople.isEmpty()) {
//    if (!nodesEdgesData.isEmpty()&& !indexValue.isEmpty() && !keyPeople.isEmpty()) {
        relationshipTab = true;
    }

    result.put("wordCloud", wordCloud);
    result.put("sentimentScore", sentimentScore);
    result.put("sentimentDistribution", sentimentDistribution);
    if (!wordCloud.isEmpty() && !sentimentScore.isEmpty() && !sentimentDistribution.isEmpty()) {
        sentimentTab = true;
    }

    result.put("selfPerception", selfPerception);
    if (!selfPerception.isEmpty()) {
        componentTab = true;
    }

    result.put("relationshipTab", relationshipTab);
    result.put("sentimentTab", sentimentTab);
    result.put("componentTab", componentTab);
    response.setContentType("text/html");
    response.getWriter().println(result);
%>
