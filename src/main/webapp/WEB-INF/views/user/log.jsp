<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-9">
                                        <h4 class="card-title">회원로그</h4>
                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <div class="input-group-prepend hover-cursor" id="navbar-search-icon">
                                                    <span class="input-group-text" id="search">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </div>
                                                <input type="text" class="form-control" id="navbar-search-input" placeholder="Search now" aria-label="search" aria-describedby="search">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>아이디</th>
                                            <th>로그</th>
                                            <th>날짜</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${usersLogPage.itemList}" var="usersLog">
                                            <tr onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${usersLog.logNo}</td>
                                                <td>${usersLog.id}</td>
                                                <c:choose>
                                                    <c:when test="${usersLog.logStatus == 0}">
                                                        <td>회원가입</td>
                                                    </c:when>
                                                    <c:when test="${usersLog.logStatus == 1}">
                                                        <td>인증완료</td>
                                                    </c:when>
                                                    <c:when test="${usersLog.logStatus == 1}">
                                                        <td>회원탈퇴</td>
                                                    </c:when>
                                                    <c:when test="${usersLog.logStatus == 10}">
                                                        <td>로그인</td>
                                                    </c:when>
                                                    <c:when test="${usersLog.logStatus == 11}">
                                                        <td>아웃</td>
                                                    </c:when>
                                                </c:choose>
                                                <td><fmt:formatDate value="${usersLog.logDate}" pattern="yyyy. MM. dd."/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
<br>
                                <!-- pagination -->
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <!-- preview -->
                                        <c:if test="${usersLogPage.pageMaker.prevGroupStartPage > 0}">
                                            <li class="page-item">
                                                <a class="page-link" href="/user/log/${usersLogPage.pageMaker.prevGroupStartPage}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                            </li>
                                        </c:if>
                                        <!-- n개 고정 -->
                                        <c:forEach begin="${usersLogPage.pageMaker.blockBegin}" end="${usersLogPage.pageMaker.blockEnd}" var="no">
                                            <c:if test="${no == usersLogPage.pageMaker.curPage}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/user/log/${no}">${no}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${no != usersLogPage.pageMaker.curPage}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/user/log/${no}">${no}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <!-- next -->
                                        <c:if test="${usersLogPage.pageMaker.nextGroupStartPage <= usersLogPage.pageMaker.totPage}">
                                            <li class="page-item">
                                                <a class="page-link" href="/user/log/${usersLogPage.pageMaker.nextGroupStartPage}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
