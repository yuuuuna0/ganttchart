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
                                                <td>${usersLog.logDate}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>


                                <!-- pagination -->
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                            <c:set var="page" value="${usersLogPage.pageMaker.curPage}"/>
                                            <!-- page maxpage를 넘었을 경우 제한 -->
                                            <c:if test="${page > usersLogPage.pageMaker.totPage}">
                                                <c:set var="page" value="${usersLogPage.pageMaker.totPage}"/>
                                            </c:if>

                                            <!-- 페이지를 5개씩 나누기 위해 현재 페이지에 보여줄 max값 설정 -->
                                            <fmt:formatNumber value="${page/3 - (page/3 % 1)}" type="pattern" pattern="0" var="full"/>
                                            <c:set var="full" value="${full * 3}"/>

                                            <!-- prev(전페이지), next(다음페이지) 개수 설정 -->
                                            <c:set var="scope" value="${page%3}"/>
                                            <c:choose>
                                                <c:when test="${scope == 0}">
                                                    <c:set var="prev" value="3"/>
                                                    <c:set var="next" value="1"/>
                                                </c:when>
                                                <c:when test="${scope < 4}">
                                                    <c:set var="prev" value="${scope}"/>
                                                    <c:set var="next" value="${3-scope}"/>
                                                </c:when>
                                            </c:choose>

                                            <!-- prev 버튼 -->
                                            <c:if test="${page > 3}">
                                                <fmt:formatNumber value="${(page-1)/3 - (((page-1)/3) % 1)}" type="pattern" pattern="0" var="prevb"/>
                                                <c:set value="${(prevb-1)*3 + 1}" var="prevb"/>
<%--                                                <span id="prevBtn" class="prev button" value="${prevb}"></span>--%>
                                                <li class="page-item">
                                                    <a class="page-link" href="/admin/userLog/${prevb}" value="${prevb}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <!-- 전 페이지 -->
                                            <c:if test="${page != 1}">
                                                <c:set var="j" value="${prev}"/>
                                                <c:forEach var="i" begin="1" end="${prev-1}">
                                                    <c:set var="j" value="${j - 1}"/>
                                                    <c:if test="${(page - j) > 0}">
<%--                                                        <span class="no">${page - j}</span>--%>
                                                        <li class="page-item"><a class="page-link" href="/admin/userLog/${page-j}">${page-j}</a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <!-- 현재 페이지 -->
<%--                                            <span class="no selected">${page}</span>--%>
                                                <li class="page-item"><a class="page-link" href="/admin/userLog/${page}">${page}</a></li>

                                            <!-- 다음 페이지 -->
                                            <c:if test="${page != usersLogPage.pageMaker.totPage}">
                                                <c:forEach var="i" begin="1" end="${next-1}">
                                                    <c:if test="${usersLogPage.pageMaker.totPage >= page+i}">
<%--                                                        <span class="no">${page+i}</span>--%>
                                                        <li class="page-item"><a class="page-link" href="/admin/userLog/${page+i}">${page+i}</a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <!-- next 버튼 -->
                                            <c:if test="${usersLogPage.pageMaker.totPage >= page + next}">
                                                <fmt:formatNumber value="${(page-1)/3 - (((page-1)/3) % 1)}" type="pattern" pattern="0" var="nextb"/>
                                                <c:set value="${(nextb+1)*3 + 1}" var="nextb"/>
            <%--                                                <span id="prevBtn" class="prev button" value="${nextb}"></span>--%>
                                                <a class="page-link" id="nextBtn" href="/admin/userLog/${nextb}" value="${nextb}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </c:if>
                                    </ul>
                                </nav>
                                <!-- pagination 끝 -->



                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
