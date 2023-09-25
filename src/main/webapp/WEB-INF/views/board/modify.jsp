<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <!-- 게시글 -->
                            <div class="card-body">
                                <h4 class="card-title">게시글 수정하기</h4>
                                <form name="boardModifyF" id="boardModifyF" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="boardTitle">제목</label>
                                        <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" >
                                    </div>
                                    <div class="form-group">
                                        <label for="boardContent">내용</label>
                                        <textarea class="form-control" id="boardContent" name="boardContent"></textarea>
                                    </div>
<%--                                    <div class="form-group">--%>
<%--                                        <label for="fileList">첨부파일</label>&nbsp;&nbsp;&nbsp;&nbsp;--%>
<%--                                        <label for="boardFileList" class="btn btn-primary mr-2">파일추가</label>--%>
<%--                                        <input type="file" id="boardFileList" name="boardFileList" onchange="addFile()" style="appearance: none; -webkit-appearance: none; display: none"  multiple>--%>
<%--                                        <span style="font-size:10px;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>--%>
<%--                                        <div class="input-group col-xs-12">--%>
<%--                                            <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileNameList" >--%>
<%--                                                <c:forEach items="${fileList}" var="file" varStatus="i">--%>
<%--                                                    <div class="file" id="file${file.fileNo}" style="font-size:12px;">--%>
<%--                                                            ${boardFile.originalFileName}--%>
<%--                                                                <span style="margin-left: 3px"><fmt:parseNumber value="${file.fileSize/1000}" integerOnly="true" /> kb</span>--%>
<%--                                                                <span>--%>
<%--                                                                    <img src="/static/images/icons/X.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" onclick="deleteFileDiv(${file.fileNo})" /></span>--%>
<%--                                                    </div>--%>
<%--                                                </c:forEach>--%>
<%--                                                <div id="fileList" >--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
                                </form>
                                    <div style="text-align: center">
                                        <input type="button" id="boardModifyBtn" name="boardModifyBtn" class="btn btn-primary mr-2" onclick="modifyBoard(${board.boardNo})" value="수정완료">
                                        <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/board/detail?boardNo=${board.boardNo}'" value="취소">
                                    </div>
                            </div>
                            <hr>
                            </div>
                        </div>
                    </div>
                <!-- content-wrapper ends -->
                </div>
            </div>
        </div>
        <!-- main-panel ends -->
<script>
    // 스마트에디터
    var boardContent;
    var oEditors = [];

    var smartEditor = function(){
        nhn.husky.EZCreator.createInIFrame({
            oAppRef : oEditors,
            elPlaceHolder : "boardContent",
            sSkinURI: "/smartEditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2"
        });
    }
    $(document).ready(function(){
        smartEditor();
    });

    function insertContent() {
        oEditors.getById["boardContent"].exec("UPDATE_CONTENTS_FIELD", []);
        if (boardContent === '') {
            alert('내용을 입력 해 주세요');
            oEditors.getById("boardContent").exec("FOCUS");
            return;
        } else {
            boardContent = $('#boardContent').val();
        }
    }


    /******************************** 1. 게시글 수정 **********************************/
    let fileCount = 0;      // 파일 현재 필드 숫자 -> maxCount와 비교
    let maxCount = 5;     // 최대 첨부 갯수
    let fileArray = [];
    let fileArray2 = [];
    let dataTransfer = new DataTransfer();  //array를 file로 변경하여 서버로 보내게 해줌
    function changeView(){
        $('#fileList').empty();
        let html = '';
        for(let i=0;i<fileArray.length;i++){
            html+=  '<div id="file' + i + '" style="font-size:12px;" onclick="deleteFile( ' + i + ')">'
                + fileArray[i].name
                + '<img src="/static/images/icons/X.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;"/>'
                + '</div>';
        }
        $('#fileList').append(html);
    }

    //1. 파일추가
    function addFile(){
        //1.파일 갯수 확인
        fileCount = $('.file').length;
        fileArray2 = $('#boardFileList')[0].files;
        console.log('fileArray2 : ' + fileArray2);
        if(fileCount + fileArray2.length > maxCount){
            alert("파일을 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
            return;
        } else {
            fileCount = fileCount + fileArray2.length;
        }
        //fileArray = $('#boardFileList')[0].files;
        for(let i = 0 ; i < fileArray2.length ; i++){
            fileArray.push(fileArray2[i]);
        }
        console.log(fileArray);
        fileArray2 = [];
        changeView();
    }
    //3. 뷰단에서 x 클릭한 파일 div 없애주기
    function deleteFileDiv(no){
        $('#file'+no).remove();
    }

    //2. 파일 삭제
    function deleteFile(no){
        for(let i=0 ; i<fileArray.length ; i++){
            fileArray2.push(fileArray[i]);
        }
        fileArray2.splice(no,1);
        fileArray =[];
        for(let i=0 ; i<fileArray2.length ; i++){
            fileArray.push(fileArray2[i]);
        }
        console.log(fileArray);
        fileArray2=[];
        changeView();
    }

    //3. 게시글 수정
    // --> 기존파일: 남아있는 파일 이름보내서 원래 파일에 있는지 없는지 보고 매칭해서 없으면 삭제
    // 새롭게 추가된 파일들은 input태그에 담겨있으니까 formdata에 담겨서 전달되는것!!
    function modifyBoard(no) {
        insertContent();
        let boardTitle = document.getElementById("boardTitle").value;
        boardContent = document.getElementById("boardContent").value;
        let boardNo = no;
        let formData = new FormData;

        //껍데기만 가진 파일번호 리스트
        let fileNoList = [];
        let fileNameList = $('.file');
        for(let i=0;i<fileNameList.length;i++){
            let fileNo = fileNameList[i].id.replace(/[^0-9]/g, ""); //기존에 있던 파일 번호
            fileNoList.push(fileNo);
        }

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

        formData.append("boardTitle",boardTitle);
        formData.append("boardContent",boardContent);
        formData.append("boardNo",boardNo);
        formData.append("fileNoList",fileNoList);

        //파일리스트 폼에 하나씩 붙여줘야 함
        for (let i = 0; i < fileArray.length; i++) {
            console.log("file : " + fileArray[i]);
            formData.append("fileArray", fileArray[i]);
        }
        $.ajax({
            url : '/board/modify.ajx?boardNo='+boardNo,
            method : 'POST',
            enctype: 'multipart/form-data',
            contentType : false,
            processData : false,
            traditional: true,  //원래 배열 보낼  때 쓰는데 배열  안넘어감
            data : formData,
            success : function (resultMap) {
                console.log('TEST');
                if(resultMap.code === 1){
                    window.location.href=resultMap.forwardPath;
                } else {
                    alert(resultMap.msg);
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }
</script>