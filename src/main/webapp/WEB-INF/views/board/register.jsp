<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">게시글 작성하기</h4>
                            <form name="boardWriteF" id="boardWriteF" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="boardTitle">제목</label>
                                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요">
                                </div>
                                <div class="form-group" id="smarteditor">
                                    <label for="boardContent">내용</label>
                                    <textarea class="form-control" id="boardContent" name="boardContent" rows="4" placeholder="내용을 입력하세요"></textarea>
                                </div>
<%--                                <div class="form-group">--%>
<%--                                    <label for="boardFileList" class="btn btn-primary mr-2">파일추가</label>--%>
<%--                                    <input type="file" id="boardFileList" name="boardFileList" onchange="addFile()" style="appearance: none; -webkit-appearance: none; display: none"  multiple>--%>
<%--                                    <span style="font-size:10px;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>--%>
<%--                                    <div class="input-group col-xs-12">--%>
<%--                                        <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
                            </form>
                            <div style="display: flex; float:right; margin-right: 20px;">
                                <input type="button" id="boardWriteBtn" name="boardWriteBtn" class="btn btn-primary mr-2" onclick="boardWrite()" value="작성">
                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소" onclick="location.href='/board/list?page=1&keyword='">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
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



/******************************** 1. 게시글 작성 **********************************/
    let fileCount = 0;      // 파일 현재 필드 숫자 -> maxCount와 비교
    let maxCount = 5;     // 최대 첨부 갯수
    let fileArray = [];
    let fileArray2 = [];
    function changeView(){
        $('#fileList').empty();
        let html = '';
        for(let i=0;i<fileArray.length;i++){
            html+=  '<div id="file' + i + '" style="font-size:12px;" onclick="deleteFile( ' + i + ')">'
                + fileArray[i].name
                + '<img src="/static/images/icons/X.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;"/></span>'
                + '</div>';
        }
        $('#fileList').append(html);
    }

    //1. 파일추가
    function addFile(){
        //1.파일 갯수 확인
        fileArray2 = $('#boardFileList')[0].files;
        if(fileCount + fileArray2.length > maxCount){
            alert("파일을 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
            return;
        } else {
            fileCount = fileCount + fileArray2.length;
        }
        //파일 중복검사
        for(let i=0;i<fileArray2.length;i++){
            let file2 = fileArray2[i];
            for(let j =0; j<fileArray.length;j++){
                let file = fileArray[j];
                if(file2.name === file.name){
                    alert("중복된 파일을 업로드할 수 없습니다.");
                    return;
                }
            }
        }
        for(let i = 0 ; i < fileArray2.length ; i++){
            fileArray.push(fileArray2[i]);
        }
        fileArray2 = [];
        changeView();
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
        --fileCount;
        fileArray2=[];
        changeView();
    }

    //3. 게시글 작성
    function boardWrite() {
        insertContent();    //스마트에디터
        var boardTitle = document.getElementById("boardTitle").value;
        boardContent = $('#boardContent').val();
        let formData = new FormData;
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
       //파일리스트 폼에 하나씩 붙여줘야 함 --> 다른 방식 있는지 확인()
        for (var i = 0; i < fileArray.length; i++) {
            formData.append("fileList", fileArray[i]);
        }
        $.ajax({
            url : '/board/register.ajx',
            method : 'POST',
            contentType : false,
            processData : false,
            data : formData,
            success : function (resultMap) {
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
