<%@page import="org.owen.helper.UtilHelper"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.owen.survey.ResponseHelper"%>
<%@page import="org.owen.survey.QuestionType"%>
<%@page import="org.owen.survey.Response"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>

<%@include file="../common.jsp" %>
<%System.out.println("OWENLite :::Entering survey-submit.jsp for empId : " + empId);
    String empRating = request.getParameter("emp_rating");
    System.out.println("OWENLite :::Starting survey-submit.jsp for empId : " + empId);
    if (!empRating.isEmpty()) {
        try {
            System.out.println("OWENLite :::Entering the try block in survey-submit.jspfor empId : " + empId);
            JSONArray arr = new JSONArray(request.getParameter("emp_rating"));
            ResponseHelper responseHelper = new ResponseHelper();
            List<Response> responseList = new ArrayList();
            for (int i = 0; i < arr.length(); i++) {
                JSONObject jObj = arr.getJSONObject(i);
                System.out.println("OWENLite :::survey-submit.jsp for empId : " + empId + " iterating through the jsonObj");
                Iterator<String> keys = jObj.keys();
                Response respObj = new Response();
                while (keys.hasNext()) {
                    String key = (String) keys.next();
                    if (key.equals("companyId")) {
                        respObj.setCompanyId(UtilHelper.getIntValue(jObj.getString(key)));
                    } else if (key.equals("employeeId")) {
                        respObj.setEmployeeId(UtilHelper.getIntValue(jObj.getString(key)));
                    } else if (key.equals("questionId")) {
                        respObj.setQuestionId(jObj.getInt(key));
                    } else if (key.equals("questionType")) {
                        respObj.setQuestionType(QuestionType.valueOf(jObj.getString(key)));
                    } else if (key.equals("responseValue")) {
                        respObj.setResponseValue(UtilHelper.getIntValue(jObj.getString(key)));
                    } else if (key.equals("targetEmployee") && (!(jObj.getString(key)).isEmpty())) {
                        respObj.setTargetEmployee(UtilHelper.getIntValue(jObj.getString(key)));
                    }else if (key.equals("responseString")) {
                        respObj.setResponseString(jObj.getString(key));
                    } 
                }
                responseList.add(respObj);
                System.out.println("OWENLite :::submit-we-submit.jsp ::" + comId + "::" + empId);
            }
            System.out.println("Response list size :::: " + responseList.size());
            System.out.println("OWENLite :::survey-submit.jsp for empId : " + empId + " exiting the while loop");
            boolean subResp = responseHelper.saveAllResponses(responseList);
            JSONObject respJOBJ = new JSONObject();
            respJOBJ.put("status", subResp);
            if (subResp) {
                respJOBJ.put("message", "Successfully Saved");
                System.out.println("OWENLite :::Successfully saved we response for empId : " + empId);
            } else {
                respJOBJ.put("message", "Saving failed");
                System.out.println("OWENLite :::Could not save we response for empId : " + empId);
            }
            out.print(respJOBJ.toString());
            System.out.println("OWENLite :::Exiting survey-submit.jsp for empId : " + empId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>