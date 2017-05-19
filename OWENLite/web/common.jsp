<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    int empId = 0;
    int comId = 0;
    boolean isAdmin = false;
    boolean isHR = false;
    boolean isEmployee = false;
    if (session.getAttribute("empId") != null && session.getAttribute("comId") != null) {
        empId = (Integer) session.getAttribute("empId");
        comId = (Integer) session.getAttribute("comId");
        isAdmin = (Boolean) session.getAttribute("admin");
        isHR = (Boolean) session.getAttribute("hr");
        isEmployee = (Boolean) session.getAttribute("employee");
    }
    if (empId == 0 || comId == 0) {
        response.sendRedirect("../index.jsp");
        return;
    }%>