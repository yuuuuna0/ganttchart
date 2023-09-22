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
                                        <h4 class="card-title">모임 신청 리스트</h4>
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
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>모임이름</th>
                                            <th>모임설명</th>
                                            <th>모임일</th>
                                            <th>신청마감일</th>
                                            <th>모임상태</th>
                                            <th>기타</th>
                                        </tr>
                                        </thead>
                                        <tbody id="gatheringTbody">
                                        <c:forEach items="${gatheringList}" var="gathering">
                                            <tr style="cursor: pointer;" onclick="goToGathList('${gathering.gathNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${gathering.gathNo}</td>
                                                <td>${gathering.gathTitle}</td>
                                                <td>${gathering.gathDesc}</td>
                                                <td><fmt:formatDate value="${gathering.gathDay}" pattern="yyyy. MM. dd."/></td>
                                                <td><fmt:formatDate value="${gathering.gathClose}" pattern="yyyy. MM. dd."/></td>
                                                <td>
                                                <c:choose>
                                                    <c:when test="${gathering.gathStatusNo == 1}">
                                                        모집중
                                                    </c:when>
                                                    <c:when test="${gathering.gathStatusNo == 2}">
                                                        인원마감
                                                    </c:when>
                                                    <c:when test="${gathering.gathStatusNo == 3}">
                                                        모임완료
                                                    </c:when>
                                                </c:choose>
                                                </td>
                                                <td><input type="button" value="참여리스트"></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
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
    function goToGathList(gathNo){
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
