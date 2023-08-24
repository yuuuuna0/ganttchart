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
                                        <h4 class="card-title">메뉴 목록</h4>
                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <btn class="input-group-prepend hover-cursor" id="searchBtn" style="cursor: pointer;">
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
                                            <th>Group No</th>
                                            <th>Title</th>
                                            <th>Url</th>
                                            <th>Description</th>
                                            <th>Using</th>
                                            <th>Parent Id</th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${menuListPage.itemList}" var="menu">
                                            <tr style="cursor: pointer;" onclick="goToMenu('${menu.menuNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${menu.menuNo}</td>
                                                <td>${menu.menuOrder}</td>
                                                <td>${menu.menuTitle}</td>
                                                <td>${menu.menuUrl}</td>
                                                <td>${menu.menuDesc}</td>
                                                <td>${menu.useYN}</td>
                                                <td>${menu.parentId}</td>
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
                                            <c:if test="${menuListPage.pageMaker.prevGroupStartPage > 0}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/menu/list/${menuListPage.pageMaker.prevGroupStartPage}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <!-- n개 고정 -->
                                                <c:forEach begin="${menuListPage.pageMaker.blockBegin}" end="${menuListPage.pageMaker.blockEnd}" var="no">
                                                            <c:if test="${no == menuListPage.pageMaker.curPage}">
                                                                <li class="page-item active">
                                                                    <a class="page-link" href="/menu/list/${no}">${no}</a>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${no != menuListPage.pageMaker.curPage}">
                                                                <li class="page-item">
                                                                    <a class="page-link" href="/menu/list/${no}">${no}</a>
                                                                </li>
                                                            </c:if>
                                                </c:forEach>
                                            <c:if test="${menuListPage.pageMaker.nextGroupStartPage <= menuListPage.pageMaker.totPage}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/menu/list/${menuListPage.pageMaker.nextGroupStartPage}" aria-label="Next">
                                                        <span aria-hidden="true">&laquo;</span>
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
    function goToMenu(menuNo){
        window.location.href='/menu/detail/'+menuNo;
    }
    // 검색창 입력 후 엔터키 => 검색
    $("#searchBtn").keyup(e => {
        if (e.keyCode === 13) {
            findmenuList();
            e.preventDefault();
        }
    });
    // 게시글 검색하기
    function searchmenuList(){
        let sendData;
        let keyword = $('#keyword').val();
        console.log(keyword);
        sendData = {
            'keyword' : keyword
        };

        $.ajax({
            url : '/boardList-ajax',
            method : 'POST',
            dataType : 'json',
            data : sendData,
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
                             "                                                <td>" + dataItem.boardReadcount+ "</td>\n" +
                             "                                                <td>" + dataItem.boardDate+ "</td>\n" +
                             "                                                <td>" + dataItem.boardReadcount+ "</td>\n" +
                             "                                            </tr>";
                     }
                     $('#boardTbody').append(html);

                    alert(resultJson.msg);
                    //render('#boardListPage',resultJson,)

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

