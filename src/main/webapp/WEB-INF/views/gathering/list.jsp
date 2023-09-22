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
                                    <c:forEach items="${searchGathList.itemList}" var="gathering">
                                        <div class="col-lg-3" style="cursor: pointer;" onclick="goToGathDetail(${gathering.gathNo})" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <div id="carouselExampleIndicators" class="carousel slide gathering-images" data-bs-ride="carousel" >
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
                                                    <div class="carousel-inner" style="width: 100%; height: 200px;" >
                                                        <c:forEach items="${gathering.fileList}" var="file">
                                                            <div class="carousel-item active" >
                                                                <img src="/upload/gathering/${file.saveName}" style="width: 100%; height: 100%; background-size:contain;"  >
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
                                                    <tr ><td align="center" style="padding: 10px 20px;">${gathering.gathTitle}</td></tr>
                                                    <tr><td align="center"  style="padding: 10px 20px;"><fmt:formatDate value="${gathering.gathDay}" pattern="yyyy. MM. dd."/></td></tr>
                                                    <tr><td align="center"  style="padding: 10px 20px;">
                                                            <c:choose>
                                                                <c:when test="${gathering.gathStatusNo==1}">모집중</c:when>
                                                                <c:when test="${gathering.gathStatusNo==2}">인원마감</c:when>
                                                                <c:when test="${gathering.gathStatusNo==3}">모임완료</c:when>
                                                            </c:choose>
                                                    </td></tr>
<%--                                                    <tr><td align="center"  style="padding: 10px 20px;">잔여석</td></tr>--%>
<%--                                                    <tr><td align="center"  style="padding: 10px 20px;">후기 수</td></tr>--%>
                                                </table>
                                            </div>
                                            <br>
                                        </div>
                                    </c:forEach>
                                </div>

                                <br>
                                <div class="row" >
                                    <div class="col-6 ml-3">
                                        <!-- pagination -->
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <!-- preview -->
                                                <c:if test="${searchGathList.pageMaker.blockBegin != 1}">
                                                    <li class="page-item">
                                                        <button  class="page-link" value="${searchGathList.pageMaker.prevBlockBegin}" onclick="searchUserList(${searchGathList.pageMaker.prevBlockBegin})" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                                <!-- n개 고정 -->
                                                <c:forEach begin="${searchGathList.pageMaker.blockBegin}" end="${searchGathList.pageMaker.blockEnd}" var="no">
                                                    <c:if test="${no == searchGathList.pageMaker.curPage}">
                                                        <li class="page-item active">
                                                            <button class="page-link" value="${no}" onclick="searchUserList(${no})">${no}</button>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${no != searchGathList.pageMaker.curPage}">
                                                        <li class="page-item">
                                                            <button class="page-link" value="${no}" onclick="searchUserList(${no})">${no}</button>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${searchGathList.pageMaker.blockEnd!=1 && searchGathList.pageMaker.blockEnd <= searchGathList.pageMaker.totPage}">
                                                    <li class="page-item">
                                                        <button class="page-link" value="${searchGathList.pageMaker.nextBlockBegin}" onclick="searchUserList(${searchGathList.pageMaker.nextBlockBegin})" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                            <span class="sr-only">Next</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
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
