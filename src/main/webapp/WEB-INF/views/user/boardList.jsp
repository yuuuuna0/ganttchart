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
                        <div class="card" id="boardListPage">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-9">
                                        <h4 class="card-title">게시글 목록</h4>
                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <button class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchBoardList(1);" style="cursor: pointer;">
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
                                            <th>Title</th>
                                            <th>Content</th>
                                            <th>작성자</th>
                                            <th>Date</th>
                                            <th>Read</th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${boardList}" var="board">
                                            <tr style="cursor: pointer;" onclick="goToBoardList('${board.boardNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${board.boardNo}</td>
                                                <td>${board.boardTitle}</td>
                                                <td>${board.boardContent}</td>
                                                <td>${sessionScope.loginUser.getUName()}</td>
                                                <td><fmt:formatDate value="${board.boardDate}" pattern="yyyy. MM. dd."/></td>
                                                <td>${board.boardReadcount}</td>
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
<%--                                            <c:if test="${boardListPage.pageMaker.prevGroupStartPage > 0}">--%>
<%--                                                <li class="page-item">--%>
<%--                                                    <button  class="page-link" value="${boardListPage.pageMaker.prevGroupStartPage}" onclick="searchBoardList(${boardListPage.pageMaker.prevGroupStartPage})" aria-label="Previous">--%>
<%--                                                        <span aria-hidden="true">&laquo;</span>--%>
<%--                                                        <span class="sr-only">Previous</span>--%>
<%--                                                    </button>--%>
<%--                                                </li>--%>
<%--                                            </c:if>--%>
<%--                                            <!-- n개 고정 -->--%>
<%--                                                <c:forEach begin="${boardListPage.pageMaker.blockBegin}" end="${boardListPage.pageMaker.blockEnd}" var="no">--%>
<%--                                                            <c:if test="${no == boardListPage.pageMaker.curPage}">--%>
<%--                                                                <li class="page-item active">--%>
<%--                                                                    <button class="page-link" value="${no}" onclick="searchBoardList(${no})">${no}</button>--%>
<%--                                                                </li>--%>
<%--                                                            </c:if>--%>
<%--                                                            <c:if test="${no != boardListPage.pageMaker.curPage}">--%>
<%--                                                                <li class="page-item">--%>
<%--                                                                    <button class="page-link" value="${no}" onclick="searchBoardList(${no})">${no}</button>--%>
<%--                                                                </li>--%>
<%--                                                            </c:if>--%>
<%--                                                </c:forEach>--%>
<%--                                            <c:if test="${boardListPage.pageMaker.nextGroupStartPage <= boardListPage.pageMaker.totPage}">--%>
<%--                                                <li class="page-item">--%>
<%--                                                    <button class="page-link" value="${boardListPage.pageMaker.nextGroupStartPage}" onclick="searchBoardList(${boardListPage.pageMaker.nextGroupStartPage})" aria-label="Next">--%>
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
    function goToBoardList(boardNo){
        window.location.href='/board/detail?boardNo='+boardNo;
    }

    // 검색창 입력 후 엔터키 => 검색
    $("#keyword").keyup(e => {
        if (e.keyCode === 13) {
            searchBoardList(1);
            e.preventDefault();
        }
    });
    // 게시글 검색하기
    function searchBoardList(no){
        let keyword = $('#keyword').val();
        let pageNo = no;
        window.location.href='/board/list?pageNo='+pageNo+'&keyword='+keyword;
    }

</script>
