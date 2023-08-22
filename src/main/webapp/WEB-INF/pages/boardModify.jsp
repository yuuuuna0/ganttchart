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
                                <h4 class="card-title">게시글 상세보기</h4>
                                <div style="text-align: right">
                                    <input type="button" id="boardCreateBtn" name="boardCreateBtn" class="btn btn-primary mr-2" onclick="location.href='/modifyBoard/${board.boardNo}')" value="수정">
                                    <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/deleteBoard-action/${board.boardNo}'" value="삭제">
                                </div>
                                <div class="form-group">
                                    <label for="boardTitle">제목</label>
                                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" >
                                </div>
                                <div class="form-group">
                                    <label for="boardContent">내용</label>
                                    <textarea class="form-control" id="boardContent" name="boardContent" rows="4" >${board.boardContent}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="fileList">첨부파일</label>
                                    <div class="input-group col-xs-12">
                                        <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                            <c:forEach items="${boardFileList}" var="boardFile">
                                                <div id="file'+ fileNo + '" style="font-size:12px;">
                                                        ${boardFile.fileName}
                                                    <img src="../../images/icon_download.jpg" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" alt="default.jpg"/>
                                                    <img src="../../images/icon_delete.jpg" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" alt="default.jpg"/>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
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
    //하위타입 댓글 작성
    function subComments(e,id){
        console.log(e.target.parentElement);
        $('#commentsContent').focus();
        $('#msgLabel').text(id+'님에게 댓글 다는 중,,,,');
        $('#createCommentsBtn').prop('onclick','createComments(2)');    //-> classNo 2 넘기는 방법?
    }

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
                reload(resultJson);
            },
            error : function(e){
                console.log(e);
                console.log('에러확인');
            },
            async : true
        });
    }
    /******************************** 2. 댓글 삭제 **********************************/
    function deleteComments(commentsNo){
        let boardNo = $('#boardNo').val();
        $.ajax({
            url : '/deleteComment-ajax',
            method : 'POST',
            data : {
                'commentsNo' : commentsNo,
                'boardNo' : boardNo
            },
            success : function(resultJson){
                reload(resultJson);
            },
            error : function (e) {
                console.log(e);
            },
            async : true
        });
    }
    /******************************** 3. 댓글 수정 **********************************/
    function modifyComments(commentsNo,commentsContent){
        $('#commentsNo'+commentsNo).empty();
        let html = "<input type='text' class='mr-3' id='commentsNo"+commentsNo+"' value='"+commentsContent+"'/>"+
            "<button onclick='modifyCommentsAction("+commentsNo+")'>수정하기</button>";
        $('#commentsNo'+commentsNo).append(html);
    }
    // //수정하는 댓글 색만 변경하기
    // $('img[name="modifyComment"]').click(function(){
    //     $('.mr-3').css('color','black');
    //     $(this).css('color','red');
    // });

    function modifyCommentsAction(commentsNo) {
        let commentsContent = $('#commentsNo'+commentsNo).val();    //왜 ""로 들어가지?
        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/modifyComment-ajax',
            method: 'POST',
            data: {
                'commentsNo' : commentsNo,
                'commentsContent' : commentsContent,
                'boardNo' : boardNo
            },
            success: function(resultJson){
                reload(resultJson);
            },
            error : function(e){
                alert(e);
            },
            async : true
        });
    }

    /******************************** 공통함수(화면 다시 뿌리기) **********************************/
    function reload(resultData){
        if(resultData.code === 1){
            $('#commentListDiv').empty();
            let html = '';
            for(let i=0; i<resultData.data;i++){
                let dataItem = data[i];
                if(dataItem.classNo === 1){
                    //부모댓글일 때 ==> classNo=1
                    html += " <div class='col-12 mt-3' >\n" +
                        "                                                    <span class='mr-3'>"+dataItem.id+"</span>\n" +
                        "                                                    <span class='mr-3' id='commentsNo"+dataItem.commentsNo+"'>"+dataItem.commentsContent+"</span>\n" +
                        "                                                    <span class='mr-2'>"+dataItem.commentsDate+"</span>\n" +
                        "                                                    <span >\n" +
                        "                                                        <img src='../../images/icon_subCommentCreate.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='createComments(2)'/>\n" +
                        "                                                        <img src='../../images/icon_modifyComment.png' name='modifyComment' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='modifyComments("+dataItem.commentsNo+")'/>\n" +
                        "                                                        <img src='../../images/icon_deleteComment.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='deleteComments("+dataItem.commentsNo+")'/>\n" +
                        "                                                    </span>\n" +
                        "                                                </div>\n";
                } else{
                    //답글일 때 ==> classNo=2
                    html += " <div class='col-1'>\n" +
                        "                                                    &nbsp\n" +
                        "                                                </div>\n" +
                        "                                                <div class='col-11'>\n" +
                        "                                                    <img src='../../images/icon_subComment.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' />\n" +
                        "                                                    <span class='mr-3'>"+dataItem.id+"</span>\n" +
                        "                                                    <span class='mr-3' id='commentsNo"+dataItem.commentsNo+"'>"+dataItem.commentsContent+"</span>\n" +
                        "                                                    <span class='mr-2'>"+dataItem.commentsDate+"</span>\n" +
                        "                                                    <span >\n" +
                        "                                                        <img src='../../images/icon_modifyComment.png' name='modifyComment' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='modifyComments("+dataItem.commentsNo+")'/>\n" +
                        "                                                        <img src='../../images/icon_deleteComment.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='deleteComments("+dataItem.commentsNo+")'/>\n" +
                        "                                                    </span>\n" +
                        "                                                </div>\n";
                }
            }
            $('#commentListDiv').append(html);
        } else {
            alert(resultData.msg);
        }
    }
</script>
</html>