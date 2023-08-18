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
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Skydash Admin</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="../../vendors/feather/feather.css">
    <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="../../images/favicon.png" />
</head>

<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <jsp:include page="include/navbar.jsp"/>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->
        <jsp:include page="include/settings-panel.jsp"/>
        <!-- partial -->
        <!-- partial:partials/_sidebar.html -->
        <jsp:include page="include/sidebar.jsp"/>
        <!-- partial -->
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
                                            <th>Title</th>
                                            <th>Content</th>
                                            <th>Writer</th>
                                            <th>Comment</th>
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
                                                <td>${board.boardReadcount}</td>
                                                <td>${board.boardDate}</td>
                                                <td>${board.boardReadcount}</td>
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
                                            <c:if test="${boardListPage.pageMaker.prevGroupStartPage > 0}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/boardList/${boardListPage.pageMaker.prevGroupStartPage}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <!-- n개 고정 -->
                                                <c:forEach begin="${boardListPage.pageMaker.blockBegin}" end="${boardListPage.pageMaker.blockEnd}" var="no">
                                                            <c:if test="${no == boardListPage.pageMaker.curPage}">
                                                                <li class="page-item active">
                                                                    <a class="page-link" href="/boardList/${no}">${no}</a>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${no != boardListPage.pageMaker.curPage}">
                                                                <li class="page-item">
                                                                    <a class="page-link" href="/boardList/${no}">${no}</a>
                                                                </li>
                                                            </c:if>
                                                </c:forEach>
                                            <c:if test="${boardListPage.pageMaker.nextGroupStartPage <= boardListPage.pageMaker.totPage}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/boardList/${boardListPage.pageMaker.nextGroupStartPage}" aria-label="Next">
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
            <!-- partial:../../partials/_footer.html -->
            <jsp:include page="include/footer.jsp"/>
            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="../../vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="../../js/off-canvas.js"></script>
<script src="../../js/hoverable-collapse.js"></script>
<script src="../../js/template.js"></script>
<script src="../../js/settings.js"></script>
<script src="../../js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<!-- End custom js for this page-->
</body>
<script>
    function goToBoardList(boardNo){
        window.location.href='/boardDetail/'+boardNo;
    }
    // 검색창 입력 후 엔터키 => 검색
    $("#searchBtn").keyup(e => {
        if (e.keyCode === 13) {
            findBoardList();
            e.preventDefault();
        }
    });
    // 게시글 검색하기
    function searchBoardList(){
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

    function render(templateId, jsonResult={},contentId) {
        // let templateHtml = $(templateId).html(); // id로 메인페이지 화면의 html 얻기
        // let bindTemplate = Handlebars.compile(templateHtml);
        // let resultTemplate = bindTemplate(jsonResult); // {}에 JSON객체/JSON Array 넣어줌 => 메인페이지 화면 + JSON 데이터 합친 결과 = resultTemplate
        // $(templateId).html(resultTemplate); // content 부분에 resultTemplate 넣기

        let templateHtml = $(templateId).html(); // id로 메인페이지 화면의 html 얻기
        let bindTemplate = Handlebars.compile(templateHtml);
        let resultTemplate = bindTemplate(jsonResult); // {}에 JSON객체/JSON Array 넣어줌 => 메인페이지 화면 + JSON 데이터 합친 결과 = resultTemplate
        $(contentId).html(resultTemplate); // content 부분에 resultTemplate 넣기
    }

</script>

</html>
