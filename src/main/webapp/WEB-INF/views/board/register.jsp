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
                                    <input type="file" id="boardFileList" name="boardFileList" onchange="addFile()" style="appearance: none; -webkit-appearance: none; display: none"  multiple>
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

    //2. 파일 삭제
    function deleteFile(no){
      s  for(let i=0 ; i<fileArray.length ; i++){
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

    //3. 게시글 작성
    function boardWrite() {
        var boardTitle = document.getElementById("boardTitle").value;
        var boardContent = document.getElementById("boardContent").value;
        // let form = $('#boardWriteF')[0];
        // let formData = new FormData(form);
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
        console.log('boardTitle : ' + boardTitle);
        formData.append("boardContent",boardContent);
        console.log('boardContent : ' + boardContent);
       //파일리스트 폼에 하나씩 붙여줘야 함
        for (var i = 0; i < fileArray.length; i++) {
            console.log("file : " + fileArray[i]);
            formData.append("fileArray", fileArray[i]);
        }
        $.ajax({
            url : '/board/register-ajax',
            method : 'POST',
            enctype: 'multipart/form-data',
            contentType : false,
            processData : false,
            data : formData,
            success : function (resultMap) {
                console.log('TEST');
                if(resultMap.code === 1){
                    console.log("코드1번");
                    window.location.href=resultMap.forwardPath;
                } else {
                    console.log("토드2");
                    alert(resultMap.msg);
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }














































//
// let dataTransfer = new DataTransfer();
//         let files ;   //파일첨부시 files 변수에 fileList 담아주기
//         let fileArray ;   //변수에 할당된 파일을 배열로 변환(FileList -> Array)
//     //1. 다중 파일 처리
//     function fileAdd(e){
//         files = $('#boardFileList')[0].files;   //파일첨부시 files 변수에 fileList 담아주기
//         fileArray = Array.from(files);   //변수에 할당된 파일을 배열로 변환(FileList -> Array)
//         //1.파일 갯수 확인
//         if(fileCount + fileArray.length > maxCount){
//             alert("파일을 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
//             return;
//         } else {
//             fileCount = fileCount + fileArray.length;
//         }
//         //2.파일 처리
//         // let html = '';
//         for(let i=0;i<fileArray.length;i++){
//             let eachFile = fileArray[i];
//             addFile(eachFile,i);
//             dataTransfer.items.add(eachFile);
//         }
//         function addFile(file,fileNo){
//             let reader = new FileReader();
//             let html='';
//             reader.onload = function(e) {
//                 document.getElementById("fileList").innerHTML +=
//                  '<div id="file' + fileNo + '" style="font-size:12px;" onclick="fileDelete( ' + fileNo + ')">'
//                     + file.name
//                     + '<img src="/static/images/icons/X.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;"/>'
//                     + '</div>';
//             };
//             reader.readAsDataURL(file);
//             console.log(file);
//             // dataTransfer.items.add(file);
//         }
//     }
//
//     //2. 파일 부분 삭제 함수
//     // --> multiple 속성은 사용자에게 입력받은 값들을 FileList로 처리한다. FileList는 Array와 다르지만 Array.from을 사용하여 Array처럼 처리할 수 있다.
//     function fileDelete(no){
//         console.log($('#boardFileList').val());
//         console.log(dataTransfer.items);
//         $('#boardFileList').val("");
//         console.log($('#boardFileList').val());
//         //html 내 div 삭제 처리
//         $('#file'+no).remove();
//
//         //input 태그 내 실제 파일값 처리
//         // let files = $('#boardFileList')[0].files;    //사용자 입력한 파일을 변수에 할당
//         // let fileArray = Array.from(files);   //변수에 할당된 파일을 배열로 변환(FileList -> Array)
//         fileArray.splice(no,1);             //해당하는 index의 파일을 배열에서 제거
//
//         //제거한 이후 남은 배열을 dataTransfer로 처리하여 Array->FileList로 전환
//         for(let i=0; i<fileArray.length;i++){
//             let eachFile = fileArray[i];
//             dataTransfer.items.add(eachFile);
//         }
//         $('#boardFileList')[0].files = dataTransfer.files;   //제거처리된 FileList를 돌려준다.
//
//     }
//     //3. 게시글 작성
//     function boardWrite() {
//         var boardTitle = document.getElementById("boardTitle").value;
//         var boardContent = document.getElementById("boardContent").value;
//         if(boardTitle === ''){
//             alert("제목을 입력하세요");
//             document.getElementById("boardTitle").focus();
//             return false;
//         }
//         if(boardContent === ''){
//             alert("내용을 입력하세요");
//             document.getElementById("boardContent").focus();
//             return false;
//         }
//
//         document.getElementById("boardWriteF").method = 'POST';
//         document.getElementById("boardWriteF").action = '/board/register-action';
//         document.getElementById("boardWriteF").submit();
//     }


</script>

</html>


















<%--




    // function fileCheck(e){
    //
    //     //각각의 파일 배열담기 및 기타
    //     filesArray.forEach(function(f){
    //        var reader = new FileReader();
    //        reader.onload = function(e){
    //            fileList.push(f);
    //            var divHtml = document.getElementById('fileList');
    //            document.getElementById("fileList").innerHTML +=
    //                '<div id="file'+ fileNo + '" style="font-size:12px;" onclick="fileDelete( '+ fileNo + ')">'
    //                + f.name
    //                + '<img src="/static/images/icons/X.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;"/>'
    //                + '</div>';
    //            fileNo++;
    //         };
    //        reader.readAsDataURL(f);
    //        dataTransfer.items.add(f);
    //     });
    //     for(let i=0;fileList.length;i++){
    //         dataTransfer.items.add(fileList.indexOf(i));
    //     }
    //     console.log(fileList);
    //     //초기화
    //     document.getElementById("boardFileList").value='';
    //     // $('#boardFileList')[0].files=dataTransfer.files;
    //     // console.log($('#boardFileList')[0].files);
    //     // console.log(dataTransfer.files);
    //
    //
    //     // var files = e.target.files;
    //     // var filesArray = Array.prototype.slice.call(files); //파일 배열 담기
    //     // //파일 갯수 확인
    //     // if(fileCount + filesArray.length > maxCount){
    //     //     alert("파일을 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
    //     //     return;
    //     // } else {
    //     //     fileCount = fileCount + filesArray.length;
    //     // }
    // }



//fileDelete("file"+(maxCount+1));    //이거 왜한거더라


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


--%>