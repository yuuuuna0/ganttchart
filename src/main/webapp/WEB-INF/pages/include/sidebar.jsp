<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link" href="/">
                <i class="icon-grid menu-icon"></i>
                <span class="menu-title">메인페이지</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#board" aria-expanded="false" aria-controls="tables">
                <i class="icon-grid-2 menu-icon"></i>
                <span class="menu-title">게시판</span>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="board">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="/board/list/1">게시판</a></li>
                    <li class="nav-item"> <a class="nav-link" href="/board/register">게시글쓰기</a></li>
                    <li class="nav-item"> <a class="nav-link" href="/board/detail/581">게시글상세보기</a></li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#user" aria-expanded="false" aria-controls="auth">
                <i class="icon-head menu-icon"></i>
                <span class="menu-title">유저</span>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="user">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="/user/login"> 로그인 </a></li>
                    <li class="nav-item"> <a class="nav-link" href="/user/register"> 회원가입 </a></li>
                    <li class="nav-item"> <a class="nav-link" href="/user/detail/admin"> 마이페이지 </a></li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
                <i class="icon-head menu-icon"></i>
                <span class="menu-title">관리자</span>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="/user/list/1"> 회원리스트 </a></li>
                    <li class="nav-item"> <a class="nav-link" href="/user/log/1"> 회원로그 </a></li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#menu" aria-expanded="false" aria-controls="auth">
                    <i class="icon-head menu-icon"></i>
                    <span class="menu-title">메뉴관리</span>
                    <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="menu">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="/menu/register"> 메뉴만들기 </a></li>
                    <li class="nav-item"> <a class="nav-link" href="/menu/list/1"> 메뉴리스트 </a></li>
                    <li class="nav-item"> <a class="nav-link" href="/menu/detail"> 메뉴상세보기 </a></li>
                </ul>
            </div>
        </li>
    </ul>
</nav>