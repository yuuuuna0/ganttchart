<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-23
  Time: 오후 4:27
  To change this template use File | Settings | File Templates.
--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <div class="mt-lg-3">
    <nav class="sidebar sidebar-offcanvas" id="sidebar">
    <c:if test="${sessionScope.loginUser.grade == 0}">
    <div class="row mt-lg-1">
    <div class="col-4">
    <input type="button" class="btn btn-light ml-4" style="width: 120%; height: 100%; font-size: 5pt; padding: 2pt;" value="메뉴 추가" onclick="location.href='/menu/register'">
    </div>
    <div class="col-4 ml-5">
    <input type="button" class="btn btn-light mr-4" style="width: 120%; height: 100%; font-size: 5pt; padding: 2pt;" value="메뉴 삭제">
    </div>
    </div>
    </c:if>
    <hr>
    <ul class="nav" style="margin-top:0;">
    <li class="nav-item">
    <a class="nav-link" href="/">
    <i class="icon-grid menu-icon"></i>
    <span class="menu-title">메인페이지</span>
    </a>
    </li>
    <c:choose>
        <c:when test="${sessionScope.loginUser.grade == 0}">
        <c:forEach items="${preMenuList}" var="preMenu">
            <li class="nav-item">
                <a class="nav-link" data-toggle="collapse" href="#${preMenu.menuTitle}" aria-expanded="false" aria-controls="#${preMenu.menuTitle}">
                    <i class="icon-grid-2 menu-icon"></i>
                    <span class="menu-title">${preMenu.menuTitle}</span>
                    <i class="menu-arrow"></i>
                </a>
                <div class="collapse" id="${preMenu.menuTitle}">
                    <ul class="nav flex-column sub-menu">
                        <c:forEach items="${menuList}" var="subMenu">
                            <c:if test="${preMenu.menuNo == subMenu.parentId && subMenu.menuOrder != 0}">
                                <li class="nav-item"> <a class="nav-link" href="${subMenu.menuUrl}">${subMenu.menuTitle}</a></li>
                        </c:if>
                    </c:forEach>
                    </ul>
                </div>
            </li>
        </c:forEach>
        </c:when>
        <c:otherwise>
        <c:forEach items="${preMenuList}" var="preMenu">
            <c:if test="${preMenu.useYN == 1}">
                <li class="nav-item">
                    <a class="nav-link" data-toggle="collapse" href="#${preMenu.menuTitle}" aria-expanded="false" aria-controls="#${preMenu.menuTitle}">
                        <i class="icon-grid-2 menu-icon"></i>
                        <span class="menu-title">${preMenu.menuTitle}</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="${preMenu.menuTitle}">
                        <ul class="nav flex-column sub-menu">
                            <c:forEach items="${menuList}" var="subMenu">
                                <c:if test="${preMenu.menuNo == subMenu.parentId && subMenu.menuOrder != 0}">
                                    <li class="nav-item"> <a class="nav-link" href="${subMenu.menuUrl}">${subMenu.menuTitle}</a></li>
                            </c:if>
                        </c:forEach>
                        </ul>
                    </div>
                </li>
            </c:if>
        </c:forEach>
        </c:otherwise>
    </c:choose>
    </ul>
    </nav>
    </div>