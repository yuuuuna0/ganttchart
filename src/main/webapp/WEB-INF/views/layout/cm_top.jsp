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
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
            <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                <a class="navbar-brand brand-logo mr-5" href="/"><img src="/static/images/logo.svg" class="mr-2" alt="logo"/></a>
                <a class="navbar-brand brand-logo-mini" href="/"><img src="/static/images/logo-mini.svg" alt="logo"/></a>
            </div>
            <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                    <span class="icon-menu"></span>
                </button>
                <ul class="navbar-nav navbar-nav-right">
                    <c:if test="${sessionScope.loginUser != null}">
                        <li class="mt-lg-auto ">${sessionScope.loginUser.name}님 안녕하세요 &nbsp;&nbsp;</li>
                    </c:if>
                    <li class="nav-item nav-profile dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser != null && sessionScope.loginUser.photo != null}">
                                    <img class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/upload/users/${sessionScope.loginUser.photo}"/>
                                </c:when>
                                <c:otherwise>
                                    <img class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/static/images/icons/default.png" />
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser != null}">
                                    <a class="dropdown-item">
                                        <i class="ti-settings text-primary"></i>
                                        마이페이지
                                    </a>
                                    <a class="dropdown-item">
                                        <i class="ti-power-off text-primary"></i>
                                        로그아웃
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a class="dropdown-item">
                                        <i class="ti-power-off text-primary"></i>
                                        로그인
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>