<%-- 
    Document   : searchOrgList
    Created on : 6 Jul, 2017, 11:17:30 AM
    Author     : rashmi
--%>

<%@page import="org.owen.helper.UtilHelper"%>
<%@page import="org.owen.survey.Question"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.owen.employee.EmployeeList"%>
<%@page import="java.util.List"%>
<%@page import="org.owen.employee.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>


<%    EmployeeList eList = new EmployeeList();
    String keywords = request.getParameter("q");

    int qId = request.getParameter("ques") != null ? UtilHelper.getIntValue(request.getParameter("ques")) : 0;

    List<Employee> mapSmartList = null;
    if (keywords != null && !keywords.equals("")) {
        mapSmartList = eList.getEmployeeMasterList(comId);
        keywords = keywords.toLowerCase();
    } else {
        Question question = new Question();
        mapSmartList = question.getSmartListForQuestion(comId, empId, qId);
    }
    if (mapSmartList != null) {%>
<ul class="mdl-list" id="smartList-<%=qId%>">
    <%for (int incr = 0; incr < mapSmartList.size(); incr++) {
            Employee employee = mapSmartList.get(incr);
            if (empId == employee.getEmployeeId()) {
                continue;
            }
            String firstName = employee.getFirstName() != null ? employee.getFirstName().toLowerCase() : "";
            String lastName = employee.getLastName() != null ? employee.getLastName().toLowerCase() : "";
            String name = firstName + " " + lastName;
            name = name.trim();
            if (name.indexOf(keywords) >= 0 || firstName.indexOf(keywords) >= 0 || lastName.indexOf(keywords) >= 0) {
    %>
    <li class="mdl-list__item mdl-list__item--three-line people" id="people-<%=qId%>" targetempid="<%=employee.getEmployeeId()%>">
        <span class="mdl-list__item-primary-content">
            <div class="mdl-list__item-avatar" ><%= employee.getFirstName().substring(0, 1) + employee.getLastName().substring(0, 1)%></div>
            <span><%= employee.getFirstName() + " " + employee.getLastName()%></span>
            <span class="mdl-list__item-text-body">
                <div class="function"><%=employee.getFunction()%></div>
                <div class="position"><%=employee.getPosition()%></div>
                <input type="hidden" name="selectedEmpId" value=<%=employee.getEmployeeId()%>>
            </span>
        </span>
        <span class="mdl-list__item-secondary-content">
            <span class="mdl-list__item-secondary-info">Like</span>
            <a class="mdl-list__item-secondary-action mdl-button mdl-js-button mdl-button--icon mdl-button--mini-fab mdl-js-ripple-effect" href="#"></a>
        </span>
    </li>
    <%}
        }%>
</ul>
<%}%>