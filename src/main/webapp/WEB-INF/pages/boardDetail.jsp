<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                            </div>
                                        </div>
                                    </div>
                            </div>
                            <hr>
                            <!-- 댓글 시작 -->
                            <div class="card-body">
                                <!-- 작성폼 -->
                                <form class="mb-4">
                                    <textarea class="form-control" row="3" placeholder="댓글을 남겨주세요"></textarea>
                                </form>
                                <div class="d-flex mb-4">
                                    <!-- 상위댓글 -->
                                    <div class="flex-shrink-0">
                                        <!-- 댓글단사람 프로필사진  -->
                                        <img class="rounded-circle" src="https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.namu.wiki%2Fi%2FsP0VOvMOCyYzjPuXM7BDJRyE3mXqdK9bC2o5D1bT6VSxX1IGzUVpLKa8oIWxvWCzpV5d_4kHCMR2Jct3jwFILw.webp&tbnid=jXA1ajKi6Vli4M&vet=12ahUKEwitkOrk7uCAAxVBplYBHVtDDagQMygAegUIARCVAQ..i&imgrefurl=https%3A%2F%2Fnamu.wiki%2Fw%2F%25EC%25BC%2580%25EC%259D%25B4%25ED%2581%25AC&docid=_wnLp2XecgoieM&w=1000&h=750&q=%EC%BC%80%EC%9D%B4%ED%81%AC&ved=2ahUKEwitkOrk7uCAAxVBplYBHVtDDagQMygAegUIARCVAQ">
                                    </div>
                                    <div class="ms-3">
                                        <div class="fw-bold">작성자 이름</div>
                                        상위댓글입니다
                                        <!-- 하위댓글 -->
                                        <div class="d-flex mt-4">
                                            <div class="flex-shrink-0">
                                            <img class="rounded-circle" src="https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F6%2F6e%2FGolde33443.jpg%2F280px-Golde33443.jpg&tbnid=fQqBLX9avtI8rM&vet=12ahUKEwis9vf17uCAAxWYxjQHHTe8CWAQMygGegQIARB_..i&imgrefurl=https%3A%2F%2Fko.wikipedia.org%2Fwiki%2F%25EA%25B0%2595%25EC%2595%2584%25EC%25A7%2580&docid=XjDC2xaeLV6mKM&w=280&h=338&q=%EA%B0%95%EC%95%84%EC%A7%80&ved=2ahUKEwis9vf17uCAAxWYxjQHHTe8CWAQMygGegQIARB_">
                                            </div>
                                            <div class="ms-3">
                                                <div class="fw-bold">작성자 이름</div>
                                                하위댓글입니다
                                            </div>
                                        </div>
                                    </div>
                                </div>

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
</html>
