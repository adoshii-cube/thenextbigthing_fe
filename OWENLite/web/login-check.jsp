
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.owen.individual.Login"%>
<%@page import="org.owen.employee.Employee"%>
<%@page import="java.util.List"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if (username != null && !username.equals("") && password != null && !password.equals("")) {
        Login login = new Login();
        try {
            Employee emp = login.login(username, password, request.getRemoteAddr());
            session.setAttribute("empId", emp.getEmployeeId());
            session.setAttribute("comId", emp.getCompanyId());
            session.setAttribute("email", username);
            session.setAttribute("ename", emp.getFirstName() + " " + (emp.getLastName() != null ? emp.getLastName() : ""));
            session.setAttribute("esname", emp.getFirstName().substring(0, 1).toUpperCase() + (emp.getLastName() != null ? emp.getLastName().substring(0, 1).toUpperCase() : ""));
            session.setAttribute("companyName", emp.getCompanyName());

            Employee e = new Employee();
            List<String> roleList = e.getEmployeeRoleList(emp.getCompanyId(), emp.getEmployeeId());
            session.setAttribute("admin", roleList.contains("Admin"));
            session.setAttribute("hr", roleList.contains("HR"));
            session.setAttribute("employee", roleList.contains("Employee"));

            if (!roleList.contains("Admin") && !roleList.contains("HR") && roleList.contains("Employee")) {
                response.sendRedirect("employee/index.jsp");
            } else {
                response.sendRedirect("user.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
%>
<form action="index.jsp" method="post" name="loginForm">
    <input type="hidden" name="loginFailure" value="true">
</form>
<script>
    document.forms["loginForm"].submit();
</script>
<%
    }
} else {
%>
<form action="index.jsp" method="post" name="loginForm">
    <input type="hidden" name="loginFailure" value="true">
</form>
<script>
    document.forms["loginForm"].submit();
</script>
<%
    }
%>