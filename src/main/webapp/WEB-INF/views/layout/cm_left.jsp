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
    <input type="button" class="btn btn-light ml-4" style="width: 100%; height: 100%; font-size: 10pt; padding: 2pt; justify-content: center" value="로그아웃" onclick="location.href='/user/logout.action'">
    <input type="button" class="btn btn-light ml-5" style="width: 150%; height: 100%; font-size: 10pt; padding: 2pt; justify-content: center" value="마이페이지" onclick="location.href='/user/detail?uId=${sessionScope.loginUser.getUId()}'">
    </c:if>
    <c:if test="${sessionScope.loginUser == null}">
    <input type="button" class="btn btn-light ml-4" style="width: 100%; height: 100%; font-size: 10pt; padding: 2pt; align-content: center" value="로그인" onclick="location.href='/user/login'">
    <input type="button" class="btn btn-light ml-5" style="width: 150%; height: 100%; font-size: 10pt; padding: 2pt; justify-content: center" value="회원가입" onclick="location.href='/user/register'">
    </c:if>
    </div>
    </div>
    <hr>
    <c:if test="${sessionScope.loginUser.getUTypeNo() == 0}">
        <div class="row mt-lg-1 ">
        <div class="col-4 ">
        <input type="button" class="btn btn-light ml-5" style="width: 230%; height: 100%; font-size: 10pt; padding: 2pt;" value="메뉴 추가" onclick="location.href='/menu/register'">
        </div>
        </div>
    </c:if>
<br>
    <ul class="nav" style="margin-top:0;">
        <li class="nav-item">
        <a class="nav-link preMenu" href="/">
        <i class="icon-grid menu-icon"></i>
        <span class="menu-title">메인페이지</span>
        </a>
        </li>
        <li class="nav-item">
            <a class="nav-link preMenu" data-toggle="collapse" href="#user" aria-expanded="false" aria-controls="#user">
            <i class="icon-grid menu-icon"></i>
            <span class="menu-title">사용자</span>
            </a>
            <div class="collapse" id="user">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="/user/detail?uId=${sessionScope.loginUser.getUId()}">마이페이지</a>
                    </li>
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.getUTypeNo() == 1}">
                            <li class="nav-item">
                                <a class="nav-link" href="/user/boardList?uId=${sessionScope.loginUser.getUId()}">게시글 작성현황</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/user/applyList?uId=${sessionScope.loginUser.getUId()}">모임 신청현황</a>
                            </li>
                        </c:when>
                        <c:when test="${sessionScope.loginUser.getUTypeNo() == 2}">
                            <li class="nav-item">
                                <a class="nav-link" href="/user/boardList?uId=${sessionScope.loginUser.getUId()}">게시글 작성현황</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/user/gatheringList?uId=${sessionScope.loginUser.getUId()}">모임 개설현황</a>
                            </li>
                        </c:when>
                    </c:choose>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link preMenu"  data-toggle="collapse" href="#gathering" aria-expanded="false" aria-controls="#gathering">
            <i class="icon-grid menu-icon"></i>
            <span class="menu-title">모임</span>
            </a>
            <div class="collapse" id="gathering">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="/gathering/list?pageNo=1&keyword=">모임리스트</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/gathering/register">모임만들기</a>
                    </li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link preMenu" data-toggle="collapse" href="#board" aria-expanded="false" aria-controls="#board">
            <i class="icon-grid menu-icon" ></i>
            <span class="menu-title">게시판</span>
            </a>
            <div class="collapse" id="board">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="/board/list?pageNo=1&keyword=">전체게시글</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/board/register">게시글 작성</a>
                    </li>
                </ul>
            </div>
        </li> <li class="nav-item">
            <a class="nav-link preMenu" data-toggle="collapse" href="#admin" aria-expanded="false" aria-controls="#admin">
            <i class="icon-grid menu-icon" ></i>
            <span class="menu-title">관리자</span>
            </a>
            <div class="collapse" id="admin">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="/user/list?pageNo=1">전체회원</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/menu/list?pageNo=1">전체메뉴</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/gathering/list?pageNo=1">전체모임</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/board/list?pageNo=1">전체게시글</a>
                    </li>
                </ul>
            </div>
        </li>
<%--    <c:choose>--%>
<%--        <c:when test="${sessionScope.loginUser.getUTypeNo() == 0}">--%>
<%--        <c:forEach items="${preMenuList}" var="preMenu">--%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" data-toggle="collapse" href="#${preMenu.menuTitle}" aria-expanded="false" aria-controls="#${preMenu.menuTitle}">--%>
<%--                    <i class="icon-grid-2 menu-icon"></i>--%>
<%--                    <span class="menu-title">${preMenu.menuTitle}</span>--%>
<%--                    <i class="menu-arrow"></i>--%>
<%--                </a>--%>
<%--                <div class="collapse" id="${preMenu.menuTitle}">--%>
<%--                    <ul class="nav flex-column sub-menu">--%>
<%--                        <c:forEach items="${menuList}" var="subMenu">--%>
<%--                            <c:if test="${preMenu.menuNo == subMenu.parentId && subMenu.menuOrder != 0}">--%>
<%--                                <li class="nav-item"> <a class="nav-link" href="${subMenu.menuUrl}">${subMenu.menuTitle}</a></li>--%>
<%--                        </c:if>--%>
<%--                    </c:forEach>--%>
<%--                    </ul>--%>
<%--                </div>--%>
<%--            </li>--%>
<%--        </c:forEach>--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--        <c:forEach items="${preMenuList}" var="preMenu">--%>
<%--            <c:if test="${preMenu.useYN == 0}">--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link" data-toggle="collapse" href="#${preMenu.menuTitle}" aria-expanded="false" aria-controls="#${preMenu.menuTitle}">--%>
<%--                        <i class="icon-grid-2 menu-icon"></i>--%>
<%--                        <span class="menu-title">${preMenu.menuTitle}</span>--%>
<%--                        <i class="menu-arrow"></i>--%>
<%--                    </a>--%>
<%--                    <div class="collapse" id="${preMenu.menuTitle}">--%>
<%--                        <ul class="nav flex-column sub-menu">--%>
<%--                            <c:forEach items="${menuList}" var="subMenu">--%>
<%--                                <c:if test="${preMenu.menuNo == subMenu.parentId && subMenu.menuOrder != 0}">--%>
<%--                                    <li class="nav-item"> <a class="nav-link" href="${subMenu.menuUrl}">${subMenu.menuTitle}</a></li>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
<%--                </li>--%>
<%--            </c:if>--%>
<%--        </c:forEach>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>
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