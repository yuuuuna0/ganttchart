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
                        <div class="card tale-bg" id="container">
                        </div>
                    </div>
                    <div class="col-md-6 grid-margin transparent">
                        <div class="row">
                            <div class="col-md-6 mb-4 stretch-card transparent">
                                <div class="card card-tale">
                                    <div class="card-body">
                                        <p class="mb-4">오늘의 방문자 수</p>
                                        <p class="fs-30 mb-2">4006</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4 stretch-card transparent">
                                <div class="card card-dark-blue">
                                    <div class="card-body">
                                        <p class="mb-4">오늘의 가입자 수</p>
                                        <p class="fs-30 mb-2">61344</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-4 mb-lg-0 stretch-card transparent">
                                <div class="card card-light-blue">
                                    <div class="card-body">
                                        <p class="mb-4">오늘의 모임 수</p>
                                        <p class="fs-30 mb-2">34040</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 stretch-card transparent">
                                <div class="card card-light-danger">
                                    <div class="card-body">
                                        <p class="mb-4">오늘 생긴 게시물 수</p>
                                        <p class="fs-30 mb-2">47033</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <p class="card-title mb-0">종료임박 모임</p>
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
                                        <c:forEach items="${nearGathList}" var="gathering">
                                            <tr style="cursor: pointer;" onclick="goToGath('${gathering.gathNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${gathering.gathNo}</td>
                                                <td>${gathering.gathTitle}</td>
                                                <td>${gathering.gathDesc}</td>
                                                <td>${gathering.getUId()}</td>
                                                <td><fmt:formatDate value="${gathering.gathDay}" pattern="yyyy. MM. dd."/></td>
                                                <td>${gathering.gathReadcount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                        <c:forEach items="${topNboardList}" var="board">
                                            <tr style="cursor: pointer;" onclick="goToBoard('${board.boardNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${board.boardNo}</td>
                                                <td>${board.boardTitle}</td>
                                                <td>${board.boardContent}</td>
                                                <td>${board.getUId()}</td>
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
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <p class="card-title mb-0">BEST 5 모임</p>
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
                                        <c:forEach items="${topNGathList}" var="gathering">
                                            <tr style="cursor: pointer;" onclick="goToGath('${gathering.gathNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${gathering.gathNo}</td>
                                                <td>${gathering.gathTitle}</td>
                                                <td>${gathering.gathDesc}</td>
                                                <td>${gathering.getUId()}</td>
                                                <td><fmt:formatDate value="${gathering.gathDay}" pattern="yyyy. MM. dd."/></td>
                                                <td>${gathering.gathReadcount}</td>
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
    function goToBoard(boardNo){
        window.location.href='/board/detail?boardNo='+boardNo;
    }
    function goToGath(gathNo){
        window.location.href='/gathering/detail?gathNo='+gathNo;
    }
//    방문자 차트
<%--    let dateList = ${dateList};--%>
<%--    let visitorCountList =${visitorCountList};--%>
<%--    let newBoardCountList = ${newBoardCountList};--%>
<%--    let newUserCountList = ${newUserCountList};--%>

    //3. 차트에 넣기
    Highcharts.chart('container', {
        chart: {
            type: 'line'
        },
        title: {
            text: 'A week of Gantt'
        },
        // subtitle: {
        //     text: 'Source: ' +
        //         '<a href="https://en.wikipedia.org/wiki/List_of_cities_by_average_temperature" ' +
        //         'target="_blank">Wikipedia.com</a>'
        // },
        xAxis: {
            // categories: dateList
        },
        // yAxis: {
        //     title: {
        //         text: 'Temperature (°C)'
        //     }
        // },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
                name: '방문자 수'
                // data: visitorCountList
            }
            ,{
                name: '게시글 수'
                // data: newBoardCountList
            }
            ,{
                name: '가입자 수'
                // data: newUserCountList
            }
        ]
    });

</script>
