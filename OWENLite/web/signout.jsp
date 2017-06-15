<%@include file="common.jsp" %>
<%
    request.getSession().invalidate();
%>
<form action="index.jsp" method="post" name="loginForm">
    <input type="hidden" name="signOut" value="true">
</form>
<script>
    document.forms["loginForm"].submit();
</script>