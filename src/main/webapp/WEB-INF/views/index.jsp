<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-12 grid-margin">
                        <div class="row">
                            <div class="col-12 col-xl-8 mb-4 mb-xl-0">
                                <h3 class="font-weight-bold">Welcome Ganttchart</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card tale-bg">
                            <div class="card-people mt-auto">
                                <img src="/static/images/dashboard/people.svg" alt="people">
                                <div class="weather-info">
                                    <div class="d-flex">
                                        <div>
                                            <h2 class="mb-0 font-weight-normal"><i class="icon-sun mr-2"></i>31<sup>C</sup></h2>
                                        </div>
                                        <div class="ml-2">
                                            <h4 class="location font-weight-normal">Bangalore</h4>
                                            <h6 class="font-weight-normal">India</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 grid-margin transparent">
                        <div class="row">
                            <div class="col-md-6 mb-4 stretch-card transparent">
                                <div class="card card-tale">
                                    <div class="card-body">
                                        <p class="mb-4">오늘의 방문자 수</p>
                                        <p class="fs-30 mb-2">4006</p>
                                        <p>10.00% (30 days)</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4 stretch-card transparent">
                                <div class="card card-dark-blue">
                                    <div class="card-body">
                                        <p class="mb-4">오늘 생긴 게시물 수</p>
                                        <p class="fs-30 mb-2">61344</p>
                                        <p>22.00% (30 days)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-4 mb-lg-0 stretch-card transparent">
                                <div class="card card-light-blue">
                                    <div class="card-body">
                                        <p class="mb-4">오늘 가입자 수</p>
                                        <p class="fs-30 mb-2">34040</p>
                                        <p>2.00% (30 days)</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 stretch-card transparent">
                                <div class="card card-light-danger">
                                    <div class="card-body">
                                        <p class="mb-4">Number of Clients</p>
                                        <p class="fs-30 mb-2">47033</p>
                                        <p>0.22% (30 days)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
<%--                <div class="row">--%>
<%--                    <div class="col-md-6 grid-margin stretch-card">--%>
<%--                        <div class="card">--%>
<%--                            <div class="card-body">--%>
<%--                                <p class="card-title">Order Details</p>--%>
<%--                                <p class="font-weight-500">The total number of sessions within the date range. It is the period time a user is actively engaged with your website, page or app, etc</p>--%>
<%--                                <div class="d-flex flex-wrap mb-5">--%>
<%--                                    <div class="mr-5 mt-3">--%>
<%--                                        <p class="text-muted">Order value</p>--%>
<%--                                        <h3 class="text-primary fs-30 font-weight-medium">12.3k</h3>--%>
<%--                                    </div>--%>
<%--                                    <div class="mr-5 mt-3">--%>
<%--                                        <p class="text-muted">Orders</p>--%>
<%--                                        <h3 class="text-primary fs-30 font-weight-medium">14k</h3>--%>
<%--                                    </div>--%>
<%--                                    <div class="mr-5 mt-3">--%>
<%--                                        <p class="text-muted">Users</p>--%>
<%--                                        <h3 class="text-primary fs-30 font-weight-medium">71.56%</h3>--%>
<%--                                    </div>--%>
<%--                                    <div class="mt-3">--%>
<%--                                        <p class="text-muted">Downloads</p>--%>
<%--                                        <h3 class="text-primary fs-30 font-weight-medium">34040</h3>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <canvas id="order-chart"></canvas>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-md-6 grid-margin stretch-card">--%>
<%--                        <div class="card">--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="d-flex justify-content-between">--%>
<%--                                    <p class="card-title">Sales Report</p>--%>
<%--                                    <a href="#" class="text-info">View all</a>--%>
<%--                                </div>--%>
<%--                                <p class="font-weight-500">The total number of sessions within the date range. It is the period time a user is actively engaged with your website, page or app, etc</p>--%>
<%--                                <div id="sales-legend" class="chartjs-legend mt-4 mb-2"></div>--%>
<%--                                <canvas id="sales-chart"></canvas>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <p class="card-title mb-0">BEST 5 게시글</p>
                                <br>
                                <div class="table-responsive">
                                    <table class="table table-striped table-borderless">
                                        <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Title</th>
                                            <th>Content</th>
                                            <th>Writer</th>
                                            <th>Date</th>
                                            <th>Read</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${boardTopList}" var="board">
                                            <tr style="cursor: pointer;" onclick="goToBoardList('${board.boardNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${board.boardNo}</td>
                                                <td>${board.boardTitle}</td>
                                                <td>${board.boardContent}</td>
                                                <td>${board.id}</td>
                                                <td><fmt:formatDate value="${board.boardDate}" pattern="yyyy. MM. dd."/></td>
                                                <td>${board.boardReadcount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
<script>
    function goToBoardList(boardNo){
        window.location.href='/board/detail/'+boardNo;
    }
</script>
