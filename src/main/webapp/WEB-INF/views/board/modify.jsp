<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                        <textarea class="form-control" id="boardContent" name="boardContent" rows="4" >${board.boardContent}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="fileList">첨부파일</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <label for="boardFileList" class="btn btn-primary mr-2">파일추가</label>
                                        <input type="file" id="boardFileList" name="boardFileList" style="appearance: none; -webkit-appearance: none; display: none"  multiple>
                                        <span style="font-size:10px; color: gray;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>
                                        <div class="input-group col-xs-12">
                                            <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                                <c:forEach items="${boardFileList}" var="boardFile">
                                                    <div id="file'+ fileNo + '" style="font-size:12px;" onclick="fileDelete(file${boardFile.fileNo})">
                                                            ${boardFile.fileName}
                                                        <img src="../../images/icon_X.jpg" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" />
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                    <div style="text-align: center">
                                        <input type="button" id="boardModifyBtn" name="boardModifyBtn" class="btn btn-primary mr-2" onclick="modifyBoard(${board.boardNo})" value="수정완료">
                                        <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/board/detail/${board.boardNo}'" value="취소">
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
    /******************************** 1. 게시글 수정 **********************************/
    var fileCount = 0;      // 파일 현재 필드 숫자 -> maxCount와 비교
    var maxCount = 5;     // 최대 첨부 갯수
    var fileNo = 0;         //파일 고유번호
    var fileList = new Array(); //첨부파일리스트 (파일타입)
    var fileListArray; //첨부파일 어레이타입
    const dataTransfer = new DataTransfer();
    //1. 다중 파일 처리
    //1) 버튼클릭시 submit 안하기
    document.addEventListener('DOMContentLoaded', function() {
        // input file 파일 첨부시 fileCheck 함수 실행
        document.getElementById('boardFileList').addEventListener('change', fileCheck);
    });
    //2) 첨부파일 로직
    function fileCheck(e){
        var files = e.target.files;
        var filesArray = Array.prototype.slice.call(files); //파일 배열 담기
        //파일 갯수 확인
        if(fileCount + filesArray.length > maxCount){
            alert("파일을 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
            return;
        } else {
            fileCount = fileCount + filesArray.length;
        }
        //각각의 파일 배열담기 및 기타
        filesArray.forEach(function(f){
            var reader = new FileReader();
            reader.onload = function(e){
                fileList.push(f);
                console.log('왜 출력이 안되니');
                var divHtml = document.getElementById('fileList');
                document.getElementById("fileList").innerHTML +=
                    '<div id="file'+ fileNo + '" style="font-size:12px;" onclick="fileDelete(\'file' + fileNo + '\')">'
                    + f.name
                    + '<img src="/static/images/icons/X.png" style="width:10px; height:auto; vertical-align: middle; cursor: pointer;" alt="default.jpg"/>'
                    + '</div>';
                fileNo++;
            };
            reader.readAsDataURL(f);
        });
        for(let i=0;fileList.length;i++){
            dataTransfer.items.add(fileList.indexOf(i));
        }
        console.log(fileList);
        //초기화
        document.getElementById("boardFileList").value='';
    }
    //2. 파일 부분 삭제 함수
    function fileDelete(fileNo){
        //html 처리
        var no = fileNo.replace(/[^0-9]/g, "");     //fileNo(ex.file1,file2)의 index
        if(no <= maxCount){
            fileList[no].is_delete = true;
            document.getElementById(fileNo).remove();
            fileCount--;
        }
        // input 태그 처리
        fileListArray = Array.from(fileList);	////변수에 할당된 배열을 파일로 변환(Array -> fileList)
        fileListArray.splice(no, 1);	            //해당하는 index의 파일을 배열에서 제거
        for(let i=0;i<fileListArray.length;i++){
            let file = fileListArray[i];
            dataTransfer.items.add(file);
        }
        $('#boardFileList')[0].files=dataTransfer.files;    //제거처리된 FileList를 input태그에 담아줌
    }
    function modifyBoard(no){
        let boardNo = no;
        let boardTitle = $('#boardTitle').val();
        let boardContent = $('#boardContent').val();
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
        //fileDelete function이 시행되어야 fileList가 input태그에 담기기때문에 삭제가 이루어지지 않더라도 function 시행위해 코드 적어줌 -> 파라미터가 존재하지 않는 값이므로 그냥 임의의 action임
        fileDelete("file"+(maxCount+1));

        document.getElementById("boardModifyF").method = 'POST';
        document.getElementById("boardModifyF").action = '/board/modify-action/'+no;
        document.getElementById("boardModifyF").submit();
    }
</script>
</html>