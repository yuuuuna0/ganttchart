<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-08
  Time: 오전 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script src="js/scripts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css"/>
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
                </form>

                <div id="comments">
                    <ol>
                        <li>
                            <div class="review_strip_single" id="comment">
                                <div class="avatar">
                                    <a href="user-view"><img src="img/defaultImg_s.png" class="img-fluid styled profile_pic2 rounded-circle" alt="Image"></a>
                                </div>

                                <div>
                                    <small name="commentsDate" id="commentsDate" text=""></small>
                                    <h4 style="font-size:20px; line-height:35px;" name="id" id="id" text=""></h4>
                                    <br>
                                    <p name="commentsContent" id="commentsContent" style="white-space:pre-line; font-size:17px;"></p>
                                    <br>
                                    <div>
                                        <a class="btn_1" href="" role="button" value=""
                                           id="commentsModify">수정</a>
                                        <a class="btn_1" href="" role="button" value=""
                                           id="commentsDelete">삭제</a>
                                    </div>
                                </div>
                            </div>
                    </ol>
                </div>
                <!-- End Comments -->

                <h4>댓글</h4>
                <form name="tt" method="post">
                    <input type="hidden" name="tCoNo" value="10"/>
                    <input type="hidden" name="tBoNo" value="" th:value="${tripBoard.tBoNo}"/>
                    <div th:if="${loginUser != null}">
                        <input type="hidden" name="userId" value="user1" th:value="${loginUser.userId}"/>
                    </div>
                    <div class="form-group">
                        <textarea  class="form-control style_2" style="height:150px;" placeholder="댓글을 써주세요." name="tCommentContent"></textarea>
                    </div>
                    <div class="form-group">

                        <button class="btn_1" type="button" onclick="tripboardCommentWriteAction();">등록</button>
                    </div>
                </form>


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
</html>
