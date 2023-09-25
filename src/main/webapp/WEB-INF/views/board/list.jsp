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
                                                <button class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchBoard(1,'','');" style="cursor: pointer;">
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
                                            <th>No
                                                <span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchBoard(1,'board_no','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchBoard(1,'board_no','desc')">
                                                </span>
                                            </th>
                                            <th>Title</th>
                                            <th>Content</th>
                                            <th>작성자</th>
                                            <th>Date
                                                <span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchBoard(1,'board_date','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchBoard(1,'board_date','desc')">
                                                </span>
                                            </th>
                                            <th>Read
                                                <span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchBoard(1,'board_readcount','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchBoard(1,'board_readcount','desc')">
                                                </span>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${searchBoardList.itemList}" var="board">
                                            <tr style="cursor: pointer;" onclick="goToBoardList('${board.boardNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${board.boardNo}</td>
                                                <td>${board.boardTitle}</td>
                                                <td>${board.boardContent}</td>
                                                <c:forEach items="${userList}" var="user">
                                                    <c:if test="${board.getUId() == user.getUId()}">
                                                        <td>${user.getUName()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td><fmt:formatDate value="${board.boardDate}" pattern="yyyy. MM. dd."/></td>
                                                <td>${board.boardReadcount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <br>
                                <div class="row" >
                                    <div class="col-6 ml-3">
                                        <!-- pagination -->
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <!-- preview -->
                                                <c:if test="${searchBoardList.pageMaker.blockBegin != 1}">
                                                    <li class="page-item">
                                                        <button  class="page-link" value="${searchBoardList.pageMaker.prevBlockBegin}" onclick="searchBoard(${searchBoardList.pageMaker.prevBlockBegin},'','')" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                                <!-- n개 고정 -->
                                                <c:forEach begin="${searchBoardList.pageMaker.blockBegin}" end="${searchBoardList.pageMaker.blockEnd}" var="no">
                                                    <c:if test="${no == searchBoardList.pageMaker.curPage}">
                                                        <li class="page-item active">
                                                            <button class="page-link" value="${no}" onclick="searchBoard(${no},'','')">${no}</button>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${no != searchBoardList.pageMaker.curPage}">
                                                        <li class="page-item">
                                                            <button class="page-link" value="${no}" onclick="searchBoard(${no},'','')">${no}</button>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${searchBoardList.pageMaker.blockEnd!=1 && searchBoardList.pageMaker.blockEnd <= searchBoardList.pageMaker.totPage}">
                                                    <li class="page-item">
                                                        <button class="page-link" value="${searchBoardList.pageMaker.nextBlockBegin}" onclick="searchBoard(${searchBoardList.pageMaker.nextBlockBegin},'','')" aria-label="Next">
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
    function goToBoardList(boardNo){
        window.location.href='/board/detail?boardNo='+boardNo;
    }

    // 검색창 입력 후 엔터키 => 검색
    $("#keyword").keyup(e => {
        if (e.keyCode === 13) {
            searchBoard(1,'','')
            e.preventDefault();
        }
    });

    let filterType;
    let ascDesc;
    // 게시글 검색하기
    function searchBoard(no,filterType2,ascDesc2){
        let keyword = $('#keyword').val();
        let pageNo = no;
        filterType = "";
        ascDesc ="";
        if(filterType2 !== ""){
            filterType = filterType2;
        }
        if(ascDesc2 !== ""){
            ascDesc = ascDesc2;
        }
        window.location.href='/board/list?pageNo='+pageNo+'&keyword='+keyword+"&filterType="+filterType+"&ascDesc="+ascDesc;
    }

</script>
