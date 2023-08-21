<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="../../vendors/select2/select2.min.css">
    <link rel="stylesheet" href="../../vendors/select2-bootstrap-theme/select2-bootstrap.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="../../images/favicon.png" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <!-- 게시글 -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-8">
                                        <h4 class="card-title">게시글 목록</h4>
                                    </div>
                                    <div class="col-4">
                                        <input type="button" id="boardCreateBtn" name="boardCreateBtn" class="btn btn-primary mr-2" onclick="boardCreate()" value="수정">
                                        <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="삭제">

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="boardTitle">제목</label>
                                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" disabled>
                                </div>
                                <div class="form-group">
                                    <label for="boardContent">내용</label>
                                    <textarea class="form-control" id="boardContent" name="boardContent" rows="4" disabled>${board.boardContent}</textarea>
                                </div>
                                    <div class="form-group">
                                        <label for="fileList">첨부파일</label>
                                        <div class="input-group col-xs-12">
                                            <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                                <c:forEach items="${boardFileList}" var="boardFile">
                                                <div id="file'+ fileNo + '" style="font-size:12px;">
                                                ${boardFile.fileName}
                                                <img src="../../images/icon_download.jpg" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" alt="default.jpg"/>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                            <hr>
                            <!-- 댓글 시작 -->
                            <div class="card-body" >
                                <input type="hidden" value="${board.boardNo}" id="boardNo">
                                <!-- 1. 댓글 목록-->
                                <div class="comment-group">
                                    <div class="row" id="commentListDiv">
                                        <c:forEach items="${commentsList}" var="comment">
                                            <c:if test="${comment.classNo == 1}">
                                                <div class="col-8 mt-3">
                                                    <span class="mr-3">${comment.id}</span>
                                                    <span class="mr-3">${comment.commentsContent}</span>
                                                    <span >${comment.commentsDate}</span>
                                                </div>
                                                <div class="col-4 mt-3">
                                                    <img src="../../images/icon_subCommentCreate.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" onclick="createComments(2)"/>
                                                    <img src="../../images/icon_deleteComment.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />
                                                </div>
                                            </c:if>
                                            <c:if  test="${comment.classNo == 2}">
                                                <div class="col-1">
                                                    &nbsp
                                                </div>
                                                <div class="col-7">
                                                    <img src="../../images/icon_subComment.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />
                                                    <span class="mr-3">${comment.id}</span>
                                                    <span class="mr-3">${comment.commentsContent}</span>
                                                    <span >${comment.commentsDate}</span>
                                                </div>
                                                <div class="col-4">
                                                    <img src="../../images/icon_deleteComment.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>

                                <hr>
                                <!-- 작성폼 -->
                                <form class="mb-4" id="createCommentsF" name="createCommentsF">
                                    <div class="row">
                                        <div class="col-9">
                                            <textarea class="form-control" id="commentsContent" name="commentsContent" row="3" placeholder="댓글을 남겨주세요"></textarea>
                                        </div>
                                        <div class="col-3">
                                            <input type="button" onclick="createComments(1)" value="남기기">
                                        </div>
                                    </div>
                                </form>
<%--                                <c:forEach items="${commentsList}" var="comments">--%>
<%--                                    <div class="d-flex mb-4">--%>
<%--                                    <c:if test="${comments.classNo == 1}">--%>
<%--                                        <!-- 상위댓글 -->--%>
<%--                                        <div class="flex-shrink-0">--%>
<%--                                            <img class="rounded-circle" src="https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.namu.wiki%2Fi%2FsP0VOvMOCyYzjPuXM7BDJRyE3mXqdK9bC2o5D1bT6VSxX1IGzUVpLKa8oIWxvWCzpV5d_4kHCMR2Jct3jwFILw.webp&tbnid=jXA1ajKi6Vli4M&vet=12ahUKEwitkOrk7uCAAxVBplYBHVtDDagQMygAegUIARCVAQ..i&imgrefurl=https%3A%2F%2Fnamu.wiki%2Fw%2F%25EC%25BC%2580%25EC%259D%25B4%25ED%2581%25AC&docid=_wnLp2XecgoieM&w=1000&h=750&q=%EC%BC%80%EC%9D%B4%ED%81%AC&ved=2ahUKEwitkOrk7uCAAxVBplYBHVtDDagQMygAegUIARCVAQ">--%>
<%--                                        </div>--%>
<%--                                        <div class="ms-10">--%>
<%--                                            <div class="fw-bold">--%>
<%--                                                    ${comments.id}--%>
<%--                                            </div>--%>
<%--                                            ${comments.commentsContent}--%>
<%--                                        </div>--%>
<%--                                        <div class="ms-3">--%>
<%--                                            <img src="../../resources/static/images/icon_subComment.png">--%>
<%--                                        </div>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${comments.classNo == 2}">--%>
<%--                                        <!-- 하위댓글 -->--%>
<%--                                        <div class="flex-shrink-0">--%>
<%--                                            <img class="rounded-circle" src="https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F6%2F6e%2FGolde33443.jpg%2F280px-Golde33443.jpg&tbnid=fQqBLX9avtI8rM&vet=12ahUKEwis9vf17uCAAxWYxjQHHTe8CWAQMygGegQIARB_..i&imgrefurl=https%3A%2F%2Fko.wikipedia.org%2Fwiki%2F%25EA%25B0%2595%25EC%2595%2584%25EC%25A7%2580&docid=XjDC2xaeLV6mKM&w=280&h=338&q=%EA%B0%95%EC%95%84%EC%A7%80&ved=2ahUKEwis9vf17uCAAxWYxjQHHTe8CWAQMygGegQIARB_">--%>
<%--                                        </div>--%>
<%--                                        <div class="ms-10">--%>
<%--                                            <div class="fw-bold">--%>
<%--                                                    ${comments.id}--%>
<%--                                            </div>--%>
<%--                                                ${comments.commentsContent}--%>
<%--                                        </div>--%>
<%--                                    </c:if>--%>
<%--                                    </div>--%>
<%--                                </c:forEach>--%>

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
</body>


<!-- plugins:js -->
<script src="../../vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="../../vendors/typeahead.js/typeahead.bundle.min.js"></script>
<script src="../../vendors/select2/select2.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="../../js/off-canvas.js"></script>
<script src="../../js/hoverable-collapse.js"></script>
<script src="../../js/template.js"></script>
<script src="../../js/settings.js"></script>
<script src="../../js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="../../js/file-upload.js"></script>
<script src="../../js/typeahead.js"></script>
<script src="../../js/select2.js"></script>
<script src="../../images"></script>
<!-- End custom js for this page-->
<script>
    /******************************** 1. 댓글 작성 **********************************/
    //상위타입 댓글 작성
    function createComments(classNo){
        let commentsContent = $('#commentsContent').val();
        let boardNo = $('#boardNo').val();
        $.ajax({
            url : '/createComments-ajax',
            method : 'POST',
            dataType : 'json',
            data : {
                'commentsContent' : commentsContent,
                'classNo' : classNo,
                'boardNo' : boardNo
            },
            success : function(resultJson){
                if(resultJson.code === 1){
                    $('#commentListDiv').empty();
                    let html = '';
                    for(let i=0; i<resultJson.data;i++){
                        let dataItem = data[i];
                        if(dataItem.classNo === 1){
                            //부모댓글일 때 ==> classNo=1
                            html += "<div class='col-8 mt-3'>\n" +
                                "         <span class='mr-3'>"+dataItem.id+"</span>\n" +
                                "         <span class=\"mr-3\">"+dataItem.commentsContent+"</span>\n" +
                                "         <span >"+dataItem.commentsDate+"</span>\n" +
                                "         </div>\n" +
                                "         <div class='col-4 mt-3'>\n" +
                                "         <img src='../../images/icon_subComment.png' style='width:20px; height:auto; vertical-align: middle; cursor: pointer;' alt='default.jpg' onclick='createComments(2)'/>\" +
                                "         <img src='../../images/icon_deleteComment.png' style='width:20px; height:auto; vertical-align: middle; cursor: pointer;' />"+
                                "         </div>";
                        } else{
                            //답글일 때 ==> classNo=2
                            html += "<div class='col-1'>\n" +
                                "         &nbsp\n" +
                                "         </div>\n" +
                                "         <div class='col-8'>\" +
                                "         <img src='../../images/icon_subComment.png' style='width:20px; height:auto; vertical-align: middle; cursor: pointer;' />"
                                "         <span class='mr-3'>"+dataItem.id+"</span>\n" +
                                "         <span class='mr-3'>"+dataItem.commentsContent+"</span>\n" +
                                "         <span >"+dataItem.commentsDate+"</span>\n" +
                                "         </div>\n" +
                                "         <div class='col-4'>\n" +
                                "        <img src='../../images/icon_deleteComment.png' style='width:20px; height:auto; vertical-align: middle; cursor: pointer;' />" +
                                "         </div>";
                        }
                    }
                    $('#commentListDiv').append(html);
                } else {
                    alert(resultJson.msg);
                }
            },
            error : function(e){
                console.log(e);
                console.log('에러확인');
            },
            async : true
        });

    }


</script>
</html>
