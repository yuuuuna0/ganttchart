<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-22
  Time: 오후 6:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Custom Logout Page</h1>
<form method="post" action="/customLogout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <button>로그아웃</button>
</form>
</body>
</html>
