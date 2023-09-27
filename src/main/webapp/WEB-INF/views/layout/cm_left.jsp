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

    <div class="row mt-lg-1 " style="padding-left: 10px ">
    <div class="col-4" style="display: flex; ">
    <c:if test="${sessionScope.loginUser != null}">
    <input type="button" class="btn btn-light ml-3" style="width: 120%; height: 100%; font-size: 10pt; padding: 2pt; justify-content: center" value="로그아웃" onclick="location.href='/user/logout.action'">
    <input type="button" class="btn btn-light ml-5" style="width: 150%; height: 100%; font-size: 10pt; padding: 2pt; justify-content: center" value="마이페이지" onclick="location.href='/user/detail?uId=${sessionScope.loginUser.getUId()}'">
    </c:if>
    <c:if test="${sessionScope.loginUser == null}">
    <input type="button" class="btn btn-light ml-4" style="width: 100%; height: 100%; font-size: 10pt; padding: 2pt; align-content: center" value="로그인" onclick="location.href='/user/login'">
    <input type="button" class="btn btn-light ml-5" style="width: 150%; height: 100%; font-size: 10pt; padding: 2pt; justify-content: center" value="회원가입" onclick="location.href='/user/register'">
    </c:if>
    </div>
    </div>
    <hr>
    <c:if test="${sessionScope.loginUser.auth == 'ROLE_ADMIN'}">
        <div class="row mt-lg-1 ">
        <div class="col-4 ">
        <input type="button" class="btn btn-light ml-5" style="width: 230%; height: 100%; font-size: 10pt; padding: 2pt;" value="메뉴 추가" onclick="location.href='/admin/menu/register'">
        </div>
        </div>
    </c:if><c:if test="${sessionScope.loginUser.auth == 'ROLE_HOST'}">
        <div class="row mt-lg-1 ">
        <div class="col-4 ">
        <input type="button" class="btn btn-light ml-5" style="width: 230%; height: 100%; font-size: 10pt; padding: 2pt;" value="모임 추가" onclick="location.href='/gathering/register'">
        </div>
        </div>
    </c:if>
<br>
    <ul class="nav" style="margin-top:0;">
    <c:forEach items="${menuList}" var="premenu">
<%--        시큐리티 적용 못해서 케이스 구분해줌--%>
        <c:choose>
            <c:when test="${sessionScope.loginUser.auth == 'ROLE_ADMIN'}">
            <c:if test="${premenu.orders == 0 }"> <%--&& premenu.auth == sessionScope.loginUser.auth}"> 비회원일때 뭐 보여ㅑ줄지 생각해야함 --%>
            <li class="nav-item">
                <a class="nav-link preMenu" data-toggle="collapse" href="#${premenu.menuUrl}" aria-expanded="false" aria-controls="#${premenu.menuUrl}">
            <i class="icon-grid menu-icon"></i>
            <span class="menu-title">${premenu.menuTitle}</span>
            </a>
                <div class="collapse" id="${premenu.menuUrl}">
                    <ul class="nav flex-column sub-menu">
                        <c:forEach items="${menuList}" var="menu">
                            <c:if test="${premenu.menuNo == menu.parentId && menu.menuNo != menu.parentId }">  <%--&& menu.auth == sessionScope.loginUser.auth}">--%>
                        <li class="nav-item">
                            <a class="nav-link" href="${menu.menuUrl}">${menu.menuTitle}</a>
                        </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </li>
            </c:if>
            </c:when>
            <c:when test="${sessionScope.loginUser.auth == 'ROLE_HOST'}">
            <c:if test="${premenu.orders == 0 && (premenu.auth =='ROLE_USER' || premenu.auth =='ROLE_HOST')}">
            <li class="nav-item">
                <a class="nav-link preMenu" data-toggle="collapse" href="#${premenu.menuUrl}" aria-expanded="false" aria-controls="#${premenu.menuUrl}">
            <i class="icon-grid menu-icon"></i>
            <span class="menu-title">${premenu.menuTitle}</span>
            </a>
                <div class="collapse" id="${premenu.menuUrl}">
                    <ul class="nav flex-column sub-menu">
                        <c:forEach items="${menuList}" var="menu">
                            <c:if test="${premenu.menuNo == menu.parentId && menu.menuNo != menu.parentId && (menu.auth =='ROLE_USER' || menu.auth =='ROLE_HOST') }">  <%--&& menu.auth == sessionScope.loginUser.auth}">--%>
                        <li class="nav-item">
                            <a class="nav-link" href="${menu.menuUrl}">${menu.menuTitle}</a>
                        </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </li>
            </c:if>
            </c:when>
            <c:otherwise>
                <c:if test="${premenu.orders == 0 && premenu.auth =='ROLE_USER'}">
                    <li class="nav-item">
                        <a class="nav-link preMenu" data-toggle="collapse" href="#${premenu.menuUrl}" aria-expanded="false" aria-controls="#${premenu.menuUrl}">
                            <i class="icon-grid menu-icon"></i>
                            <span class="menu-title">${premenu.menuTitle}</span>
                        </a>
                        <div class="collapse" id="${premenu.menuUrl}">
                            <ul class="nav flex-column sub-menu">
                                <c:forEach items="${menuList}" var="menu">
                                    <c:if test="${premenu.menuNo == menu.parentId && menu.menuNo != menu.parentId && menu.auth =='ROLE_USER' }">  <%--&& menu.auth == sessionScope.loginUser.auth}">--%>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${menu.menuUrl}">${menu.menuTitle}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                </c:if>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    </ul>
    </nav>
    </div>
<script>
    $(document).ready(function(){
        $('.nav-item').removeClass('active');
        $('.collapse').removeClass('show');

        //현재 선택된거는 활성되게 해야함
    });

    $('.preMenu').click(function(e){
        e.preventDefault();

        $('.preMenu').attr('aria-expanded', 'false');
        $(this).attr('aria-expanded', 'true');
        $('.collapse').collapse('hide');

        // e.target.children()
    });
</script>