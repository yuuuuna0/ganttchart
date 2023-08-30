<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                <div class="form-group" >
                                    <label for="boardContent">내용</label>
                                    <textarea class="form-control" id="boardContent" name="boardContent" rows="4" placeholder="내용을 입력하세요"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="boardFileList" class="btn btn-primary mr-2">파일추가</label>
                                    <input type="file" id="boardFileList" name="boardFileList" style="appearance: none; -webkit-appearance: none; display: none"  multiple>
                                    <span style="font-size:10px; color: gray;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>
                                    <div class="input-group col-xs-12">
                                        <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <div style="text-align: center">
                                <input type="button" id="boardWriteBtn" name="boardWriteBtn" class="btn btn-primary mr-2" onclick="boardWrite()" value="작성">
                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소">
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
/******************************** 1. 게시글 작성 **********************************/
    var fileCount = 0;      // 파일 현재 필드 숫자 -> maxCount와 비교
    var maxCount = 5;     // 최대 첨부 갯수
    var fileNo = 0;         //파일 고유번호
    var fileList = new Array(); //첨부파일리스트 (파일타입)
    var fileListArray; //첨부파일 어레이타입
    let dataTransfer = new DataTransfer();
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
                   + '<img src="/static/images/icons/X.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>'
                   + '</div>';
               fileNo++;
            };
           reader.readAsDataURL(f);
           dataTransfer.items.add(f);
        });
        for(let i=0;fileList.length;i++){
            dataTransfer.items.add(fileList.indexOf(i));
        }
        console.log(fileList);
        //초기화
        document.getElementById("boardFileList").value='';
        $('#boardFileList')[0].files=dataTransfer.files;
        console.log($('#boardFileList')[0].files);
        console.log(dataTransfer.files);
    }
    //2. 파일 부분 삭제 함수
    function fileDelete(fileNo){
        dataTransfer = new DataTransfer();
        //html 처리
        var no = fileNo.replace(/[^0-9]/g, "");     //fileNo(ex.file1,file2)의 index
        /*if(no <= maxCount){
            fileList[no].is_delete = true;
            document.getElementById(fileNo).remove();
            fileCount--;
        }*/
        // input 태그 처리
        fileListArray = Array.from(fileList);	////변수에 할당된 배열을 파일로 변환(Array -> fileList)
        console.log('fileList : ' + fileList);
        console.log('fileListArray : ' + fileListArray);
        console.log('dataTransfer : ' + dataTransfer.items);
        fileListArray.splice(no, 1);	            //해당하는 index의 파일을 배열에서 제거

        for(let i=0;i<fileListArray.length;i++){
            let file = fileListArray[i];
            dataTransfer.items.add(file);
        }
       /* console.log("2");
        console.log(fileListArray);
        console.log(dataTransfer.items);*/

        $('#fileList').empty();
        let html = ""
        for(let i = 0 ; i < dataTransfer.files.length ; i++){
            let f = dataTransfer.files[i];
            html +=  '<div id="file'+ i + '" style="font-size:12px;" onclick="fileDelete(\'file' + i + '\')">'
                + f.name
                + '<img src="/static/images/icons/X.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>'
                + '</div>';
        }
        $('#fileList').append(html);

        console.log('fileList : ' + fileList);
        console.log('fileListArray : ' + fileListArray);
        console.log('dataTransfer : ' + dataTransfer.items);

        $('#boardFileList')[0].files=dataTransfer.files;
        fileList = new Array();
        fileList = dataTransfer.files;
        //제거처리된 FileList를 input태그에 담아줌
    }
    //3. 게시글 작성
    function boardWrite() {
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
        //fileDelete("file"+(maxCount+1));    //이거 왜한거더라

        document.getElementById("boardWriteF").method = 'POST';
        document.getElementById("boardWriteF").action = '/board/register-action';
        console.log($('#boardFileList')[0].files);
        console.log($('#boardFileList'));
        document.getElementById("boardWriteF").submit();
    }


</script>

</html>
