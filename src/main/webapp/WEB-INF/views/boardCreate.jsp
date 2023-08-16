<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-08
  Time: 오전 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>GanttChart</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
<body class="sb-nav-fixed">
<!-- header start -->
<div class="header">
    <jsp:include page="include-common-top.jsp"/>
</div>
<!-- header end -->
<div id="layoutSidenav">
    <!-- left side nav start -->
    <div id="navigation">
        <jsp:include page="include-common-left.jsp"/>
    </div>
    <!-- left side nav end -->
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">게시글 작성하기</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="boardList">Return to BoardList</a></li>
                </ol>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <p></p>
                                <label>제목</label>
                                <input class="form-control" name="boardTitle" id="boardTitle" type="text" style="font-size: 30px" placeholder="제목을 작성해주세요" required="required">
                            </div>
                            <p></p>
                            <div class="form-group">
                                <label>내용</label>
                                <input type="text" style="height:500px;font-size:20px;" class="form-control" name="boardContent" id="boardContent" placeholder="내용을 작성해주세요" required="required"/>
                            </div>
                        </div>
                    </div>
                    <div class="d-grid">
                        <button type="button"class="btn btn-primary btn-block" onclick="createBoard()">작성 완료</button>
                    </div>
                    <div class="card-footer text-center py-3">
                        <div class="small"><a href="boardList">작성 취소</a></div>
                    </div>
            </div>
        </main>
        <footer class="py-4 bg-light mt-auto">
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between small">
                    <div class="text-muted">Copyright &copy; Your Website 2023</div>
                    <div>
                        <a href="#">Privacy Policy</a>
                        &middot;
                        <a href="#">Terms &amp; Conditions</a>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</div>
</body>
<script>
    function createBoard(){
        var data = {};
        data.boardTitle = document.getElementById("boardTitle").value;
        data.boardContent = document.getElementById("boardContent").value;
        $.ajax({
            type : 'POST',
            url : 'boardCreate-action',
            dataType : 'json',
            contentType : "application/json; charset=UTF-8",
            data : JSON.stringify(data),
            success : function(){
                alert("게시글 작성 성공");
                window.location.href="boardList";
            },
            error : function(){
                console.log("게시글 작성 실패");
            }
        });


    }

</script>
</html>
