<%@include file="common.jsp" %>
<%
    request.getSession().invalidate();
%>
<form action="index.jsp" method="post" name="loginForm">
</form>
<script>
    document.forms["loginForm"].submit();
</script>