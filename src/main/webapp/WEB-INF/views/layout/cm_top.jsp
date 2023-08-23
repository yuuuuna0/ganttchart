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
                <a class="navbar-brand brand-logo mr-5" href="/"><img src="../images/logo.svg" class="mr-2" alt="logo"/></a>
                <a class="navbar-brand brand-logo-mini" href="/"><img src="../images/logo-mini.svg" alt="logo"/></a>
            </div>
            <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                    <span class="icon-menu"></span>
                </button>
        <%--        <ul class="navbar-nav mr-lg-2">--%>
        <%--            <li class="nav-item nav-search d-none d-lg-block">--%>
        <%--                <div class="input-group">--%>
        <%--                    <div class="input-group-prepend hover-cursor" id="navbar-search-icon">--%>
        <%--                <span class="input-group-text" id="search">--%>
        <%--                  <i class="icon-search"></i>--%>
        <%--                </span>--%>
        <%--                    </div>--%>
        <%--                    <input type="text" class="form-control" id="navbar-search-input" placeholder="Search now" aria-label="search" aria-describedby="search">--%>
        <%--                </div>--%>
        <%--            </li>--%>
        <%--        </ul>--%>
                <ul class="navbar-nav navbar-nav-right">
                    <li class="nav-item dropdown">
                        <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
                            <i class="icon-bell mx-0"></i>
                            <span class="count"></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
                            <p class="mb-0 font-weight-normal float-left dropdown-header">Notifications</p>
                            <a class="dropdown-item preview-item">
                                <div class="preview-thumbnail">
                                    <div class="preview-icon bg-success">
                                        <i class="ti-info-alt mx-0"></i>
                                    </div>
                                </div>
                                <div class="preview-item-content">
                                    <h6 class="preview-subject font-weight-normal">Application Error</h6>
                                    <p class="font-weight-light small-text mb-0 text-muted">
                                        Just now
                                    </p>
                                </div>
                            </a>
                            <a class="dropdown-item preview-item">
                                <div class="preview-thumbnail">
                                    <div class="preview-icon bg-warning">
                                        <i class="ti-settings mx-0"></i>
                                    </div>
                                </div>
                                <div class="preview-item-content">
                                    <h6 class="preview-subject font-weight-normal">Settings</h6>
                                    <p class="font-weight-light small-text mb-0 text-muted">
                                        Private message
                                    </p>
                                </div>
                            </a>
                            <a class="dropdown-item preview-item">
                                <div class="preview-thumbnail">
                                    <div class="preview-icon bg-info">
                                        <i class="ti-user mx-0"></i>
                                    </div>
                                </div>
                                <div class="preview-item-content">
                                    <h6 class="preview-subject font-weight-normal">New user registration</h6>
                                    <p class="font-weight-light small-text mb-0 text-muted">
                                        2 days ago
                                    </p>
                                </div>
                            </a>
                        </div>
                    </li>
                    <li class="nav-item nav-profile dropdown">
        <%--                <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">--%>
        <%--                    <img src="../images/faces/face28.jpg" alt="profile"/>--%>
        <%--                </a>--%>
        <%--                <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">--%>
        <%--                    <a class="dropdown-item">--%>
        <%--                        <i class="ti-settings text-primary"></i>--%>
        <%--                        Settings--%>
        <%--                    </a>--%>
        <%--                    <a class="dropdown-item">--%>
        <%--                        <i class="ti-power-off text-primary"></i>--%>
        <%--                        Logout--%>
        <%--                    </a>--%>
        <%--                </div>--%>
                        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser != null && sessionScope.loginUser.photo != null}">
                                    <img class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="../upload/users/${sessionScope.loginUser.photo}"/>
                                </c:when>
                                <c:otherwise>
                                    <img class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="../images/icons/default.png" />
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
                    <li class="nav-item nav-settings d-none d-lg-flex">
                        <a class="nav-link" href="#">
                            <i class="icon-ellipsis"></i>
                        </a>
                    </li>
                </ul>
                <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                    <span class="icon-menu"></span>
                </button>
            </div>
        </nav>