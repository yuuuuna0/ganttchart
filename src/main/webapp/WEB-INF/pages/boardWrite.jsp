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
                        <div class="card-body">
                            <h4 class="card-title">게시글 작성하기</h4>
                            <form name="boardWriteF" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="boardTitle">제목</label>
                                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요">
                                </div>
                                <div class="form-group">
                                    <label for="boardContent">내용</label>
                                    <textarea class="form-control" id="boardContent" name="boardContent" rows="4" placeholder="내용을 입력하세요"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="boardFile">첨부파일</label> &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
                                    <input type="file" id="boardFile" name="boardFile">
                                    <div class="input-group col-xs-12">
                                        <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;"
                                               id="fileList" disabled placeholder="파일을 업로드하세요">
                                        </div>
                                    </div>
                                </div>
                            </form>
                                <input type="button" id="boardWriteBtn" name="boardWriteBtn" class="btn btn-primary mr-2" onclick="boardWrite()" value="작성">
                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소">

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
<!-- End custom js for this page-->
<script>
    //1. 게시글 작성
    function boardWrite(){
        var boardTitle = document.getElementById("boardTitle").value;
        var boardContent = document.getElementById("boardContent").value;

        if(boardTitle === ''){
            alert("제목을 입력하세요");
            document.getElementById("boardTitle").focus();
            return false;
        }
        if(boardContent === ''){
            alert("내용을 입력하세요");
            document.getElementById("boardContent").focus();
            return false;
        }

        document.boardWriteF.method = 'POST';
        document.boardWriteF.action = '/boardWrite-action';
        document.boardWriteF.submit();
    };

    // //2. 파일 여러개 업로드
    // var fileNo = 0;
    // var filesArray = new Array();
    // function uploadFiles(obj){
    //     var maxFileCount = 5;   //첨부파일 최대 개수
    //     var attFileCount = document.querySelectorAll('.filebox').length; //기존 추가된 첨부파일 개수
    //     var remailFileCount = maxFileCount - attFileCount;      //추가 첨부 가능한 개수
    //     var curFileCount = obj.files.length();
    //
    //     //1) 첨부파일 개수 확인
    //     if(curFileCount > remailFileCount){
    //         alert("첨부파일은 최대 "+ maxFileCount +"개까지 첨부 가능합니다.");
    //     } else {
    //         for(var file of obj.files){
    //             var validation = validation(file);
    //             if(validation){
    //                 var reader =new FileReader();
    //                 reader.onload = function(){
    //                     filesArray.push(file);
    //                 };
    //                 reader.readAsDataURL(file);
    //                 //목록 추가
    //                 var htmlData= "";
    //                 htmlData += '<div name="file' + fileNo + '" class="filebox">';
    //                 htmlData += '   <p class="name">' + file.name + '</p>';
    //                 htmlData += '   <a class="delete" onclick = "deleteFile('+ fileNo + ');"><i class="far fa-minus-square"/></a>';
    //                 htmlData += '</div>';
    //                 document.getElementById("fileList").append(htmlData);
    //                 fileNo++;
    //             } else {
    //                 continue;
    //             }
    //         }
    //     }
    //     //초기화
    //     document.getElementById("boardFiles").value="";
    // };
    // //2) 첨부파일 용량(100MB), 글자수(50자) 검증
    // function validation(obj){
    //     if(obj.name.length() > 100){
    //         alert("파일명이 100자 잇상인 파일은 제외되었습니다.");
    //         return false;
    //     }
    //     if(obj.size > (100*1024*1024)){
    //         alert("최대 파일 용량인 100MB를 초과하는 파일은 제외되었습니다.");
    //         return false;
    //     }
    //     return true;
    // };
    // //3) 첨부파일 삭제
    // function deleteFile(num){
    //     document.querySelector("#file" + num).remove();
    //     filesArray[num].is_delete = true;
    // };
    // //4) 폼 전송
    // function boardFileUpload(){
    //     //폼데이터 담기
    //     var form = document.boardFilesF;
    //     var formData = new FormData(form);
    //     for(var i=0; i<filesArray.length ; i++){
    //         //삭제되지 않은 파일만 폼데이터에 담기
    //         if(!filesArray[i].is_delete){
    //             formData.append("boardFiles", filesArray[i]);
    //         }
    //     }
    //     $.ajax({
    //         method : 'POST',
    //         url : '/board/write-action',
    //         dataType : 'json',
    //         data : formData,
    //         async : false,
    //         success : function(result){
    //             console.log(result);
    //             window.location.href='/board/list';
    //         },
    //         error : function(xhr,status,error){
    //             console.log(error);
    //         }
    //     });
    // }
</script>

</html>
