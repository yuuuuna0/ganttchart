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
                                                <btn class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchBoardList();" style="cursor: pointer;">
                                                    <span class="input-group-text">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </btn>
                                                <input type="text" class="form-control" id="keyword" name="keyword" placeholder="검색" aria-label="search" aria-describedby="search">
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
                                            <th>Writer</th>
                                            <th>Date</th>
                                            <th>Read</th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${boardListPage.itemList}" var="board">
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

                                <br>
                                <!-- pagination -->
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination" onclick="searchBoardList(event)">
                                            <!-- preview -->
                                            <c:if test="${boardListPage.pageMaker.prevGroupStartPage > 0}">
                                                <li class="page-item">
                                                    <a class="page-link" data-value="${boardListPage.pageMaker.prevGroupStartPage}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <!-- n개 고정 -->
                                                <c:forEach begin="${boardListPage.pageMaker.blockBegin}" end="${boardListPage.pageMaker.blockEnd}" var="no">
                                                            <c:if test="${no == boardListPage.pageMaker.curPage}">
                                                                <li class="page-item active">
                                                                    <a class="page-link" data-value="${no}">${no}</a>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${no != boardListPage.pageMaker.curPage}">
                                                                <li class="page-item">
                                                                    <a class="page-link" data-value="${no}">${no}</a>
                                                                </li>
                                                            </c:if>
                                                </c:forEach>
                                            <c:if test="${boardListPage.pageMaker.nextGroupStartPage <= boardListPage.pageMaker.totPage}">
                                                <li class="page-item">
                                                    <a class="page-link" data-value="${boardListPage.pageMaker.nextGroupStartPage}" aria-label="Next">
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
<script>
    function goToBoardList(boardNo){
        window.location.href='/board/detail/'+boardNo;
    }
    // 검색창 입력 후 엔터키 => 검색
    $("#searchBtn").keyup(e => {
        if (e.keyCode === 13) {
            searchBoardList();
            e.preventDefault();
        }
    });
    // 게시글 검색하기
    function searchBoardList(e){
        let keyword = $('#keyword').val();
        let pageNo =1;

        if (e.target.tagName === 'A') {
            pageNo = e.target.getAttribute('data-value');
            console.log('pageNo :', pageNo);
        }

            $.ajax({
            url : '/board/list-ajax',
            method : 'POST',
            dataType : 'json',
            data :  {
                'keyword' : keyword,
                'pageNo' : pageNo
            },
            success : function(resultJson){
                if(resultJson.code === 1){
                    console.log(resultJson.data);
                    let data = resultJson.data.itemList;
                    $('#boardTbody').empty();
                    let html = '';
                    for(let i = 0  ; i < data.length ; i++){
                         let dataItem = data[i];
                         console.log(dataItem);
                         html += "<tr style=\"cursor: pointer;\" onclick=\"goToBoardList('" + dataItem.boardNo + "')\" onmouseover=\"this.style.background='gray'\" onmouseout=\"this.style.background='white'\">\n" +
                             "                                                <td>" + dataItem.boardNo + "</td>\n" +
                             "                                                <td>" + dataItem.boardTitle + "</td>\n" +
                             "                                                <td>" + dataItem.boardContent+ "</td>\n" +
                             "                                                <td>" + dataItem.id+ "</td>\n" +
                             "                                                <td>" + dataItem.boardDate+ "</td>\n" +
                             "                                                <td>" + dataItem.boardReadcount+ "</td>\n" +
                             "                                            </tr>";
                     }
                     $('#boardTbody').append(html);

                    <%--// 모든 페이지 아이템에서 active 클래스 제거--%>
                    <%--let pageItems = document.querySelectorAll('.page-item');--%>
                    <%--pageItems.forEach(item => {--%>
                    <%--    item.classList.remove('active');--%>
                    <%--});--%>

                    <%--// 선택한 페이지 아이템에 active 클래스 추가--%>
                    <%--let selectedPageItem = document.querySelector(`.page-item[data-value="${pageNumber}"]`);--%>
                    <%--selectedPageItem.classList.add('active');--%>

                } else {
                    alert(resultJson.msg);
                }
            },
            error : function(e) {
                console.log(e);
                console.log('에러확인');
            },
            async : true
        });
    }

</script>
