<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-23
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
    <%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
    <%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ganttchart</title>
    <%@include file="cm_head.jsp"%>
    <decorator:head/>
</head>
<body>
    <div class="container-scroller">
        <%@include file="cm_top.jsp"%>
<%--        <page:applyDecorator name="cm_top" />--%>
        <div class ="container-fluid page-body-wrapper">

            <%@include file="cm_left.jsp"%>
<%--        <page:applyDecorator name="cm_left" />--%>
    <decorator:body >
        <%@include file="cm_bottom.jsp"%>
    </decorator:body>

    </div>
    </div>


<%--        <page:applyDecorator name="cm_bottom" />--%>

</body>

</html>
