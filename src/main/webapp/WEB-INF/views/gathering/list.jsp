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
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card" id="gatheringListPage">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-9">
                                        <h4 class="card-title">모임 리스트</h4>
                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <button class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchGathList(1);" style="cursor: pointer;">
                                                    <span class="input-group-text">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </button>
                                                <input type="text" class="form-control" id="keyword" name="keyword" value="${keyword}" placeholder="검색" aria-label="search" aria-describedby="search">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="gatheringList row">
                                    <c:forEach items="${gatheringList}" var="gathering">
                                        <div class="col-lg-3" style="cursor: pointer;" onclick="goToGathDetail(${gathering.gathNo})" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <div id="carouselExampleIndicators" class="carousel slide gathering-images" data-bs-ride="carousel">
                                                    <div class="carousel-indicators">
                                                        <c:forEach items="${gathering.fileList}" varStatus="no">
                                                            <c:choose>
                                                                <c:when test="${no.index == 0}">
                                                                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${no.index}" class="active" aria-current="true" aria-label="Slide ${no.index}"></button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${no.index}" aria-label="Slide ${no.index}"></button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="carousel-inner">
                                                        <c:forEach items="${gathering.fileList}" var="file">
                                                            <div class="carousel-item active">
                                                                <img src="/upload/gathering/${file.saveName}" style="width: 50%; height: 500px;  object-fit: cover;" class="d-block w-100" alt="...">
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Previous</span>
                                                    </button>
                                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Next</span>
                                                    </button>
                                                </div>
<%--                                                <img src="/static/images/icons/default.png" style="height: auto; width: 100%"/>--%>
                                            <div class="gathering-desc">
                                                <table class="table">
                                                    <tr><td>${gathering.gathTitle}</td></tr>
                                                    <tr><td><fmt:formatDate value="${gathering.gathDay}" pattern="yyyy. MM. dd."/></td></tr>
                                                    <tr><td>${gathering.gathStatusNo}</td></tr>
                                                    <tr><td>잔여석</td></tr>
                                                    <tr><td>후기 수</td></tr>
                                                </table>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>


















                                <br>

<%--                                <!-- pagination -->--%>
<%--                                    <nav aria-label="Page navigation example">--%>
<%--                                        <ul class="pagination">--%>
<%--                                            <!-- preview -->--%>
<%--                                            <c:if test="${gatheringListPage.pageMaker.prevGroupStartPage > 0}">--%>
<%--                                                <li class="page-item">--%>
<%--                                                    <button  class="page-link" value="${gatheringListPage.pageMaker.prevGroupStartPage}" onclick="searchBoardList(${gatheringListPage.pageMaker.prevGroupStartPage})" aria-label="Previous">--%>
<%--                                                        <span aria-hidden="true">&laquo;</span>--%>
<%--                                                        <span class="sr-only">Previous</span>--%>
<%--                                                    </button>--%>
<%--                                                </li>--%>
<%--                                            </c:if>--%>
<%--                                            <!-- n개 고정 -->--%>
<%--                                                <c:forEach begin="${gatheringListPage.pageMaker.blockBegin}" end="${gatheringListPage.pageMaker.blockEnd}" var="no">--%>
<%--                                                            <c:if test="${no == gatheringListPage.pageMaker.curPage}">--%>
<%--                                                                <li class="page-item active">--%>
<%--                                                                    <button class="page-link" value="${no}" onclick="searchBoardList(${no})">${no}</button>--%>
<%--                                                                </li>--%>
<%--                                                            </c:if>--%>
<%--                                                            <c:if test="${no != gatheringListPage.pageMaker.curPage}">--%>
<%--                                                                <li class="page-item">--%>
<%--                                                                    <button class="page-link" value="${no}" onclick="searchBoardList(${no})">${no}</button>--%>
<%--                                                                </li>--%>
<%--                                                            </c:if>--%>
<%--                                                </c:forEach>--%>
<%--                                            <c:if test="${gatheringListPage.pageMaker.nextGroupStartPage <= gatheringListPage.pageMaker.totPage}">--%>
<%--                                                <li class="page-item">--%>
<%--                                                    <button class="page-link" value="${gatheringListPage.pageMaker.nextGroupStartPage}" onclick="searchBoardList(${gatheringListPage.pageMaker.nextGroupStartPage})" aria-label="Next">--%>
<%--                                                        <span aria-hidden="true">&raquo;</span>--%>
<%--                                                        <span class="sr-only">Next</span>--%>
<%--                                                    </button>--%>
<%--                                                </li>--%>
<%--                                            </c:if>--%>
<%--                                        </ul>--%>
<%--                                    </nav>--%>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
<script>
    function goToGathDetail(gathNo){
        window.location.href='/gathering/detail?gathNo='+gathNo;
    }

    // 검색창 입력 후 엔터키 => 검색
    $("#keyword").keyup(e => {
        if (e.keyCode === 13) {
            searchBoardList(1);
            e.preventDefault();
        }
    });
    // 게시글 검색하기 ---> 검색후 페이지까지 들어가는데 버튼이 안먹는중,,,
    function searchBoardList(no){
        let keyword = $('#keyword').val();
        let pageNo = no;
        window.location.href='/gathering/list?pageNo='+pageNo+'&keyword='+keyword;
    }

</script>
