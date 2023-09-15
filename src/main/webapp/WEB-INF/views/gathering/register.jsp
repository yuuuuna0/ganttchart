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
                            <h4 class="card-title">모임 작성하기</h4>
                            <form name="gatheringWriteF" id="gatheringWriteF" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="gathTitle">제목</label>
                                    <input type="text" class="form-control" id="gathTitle" name="gathTitle" placeholder="제목을 입력하세요">
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="cityNo">지역</label><span style="color: red;">*</span>
                                        <select class="form-control" id="cityNo" name="cityNo">
                                            <option disabled selected>지역을 선택하세요</option>
                                            <c:forEach items="${cityList}" var="city">
                                                <option value="${city.cityNo}">${city.city}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-6">
                                        <label for="gathTypeNo">카테고리</label><span style="color: red;">*</span>
                                        <select class="form-control" id="gathTypeNo" name="gathTypeNo">
                                            <option disabled selected>모임종류를 선택하세요</option>
                                            <c:forEach items="${gathTypeList}" var="gathType">
                                                <option value="${gathType.gathTypeNo}">${gathType.gathType}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="gathAddr">주소</label>
                                        <input type="text" class="form-control" id="gathAddr" name="gathAddr"
                                               placeholder="주소를 입력하세요">
                                    </div>
                                    <div class="col-6">
                                        <label for="gathAddr2">&nbsp;</label>
                                        <input type="text" class="form-control" id="gathAddr2"
                                               name="gathAddr2" placeholder="상세주소를 입력하세요">
                                    </div>
                                </div><div class="row form-group">
                                <div class="col-4">
                                    <label for="gathDay">모임일</label>
                                    <input type="Date" class="form-control" id="gathDay" name="gathDay">
                                </div>
                                <div class="col-4">
                                    <label for="gathClose">모집마감일</label>
                                    <input type="date" class="form-control" id="gathClose" name="gathClose">
                                </div>
                                <div class="col-4">
                                    <label for="gathAmount">모집인원</label>
                                    <input type="number" class="form-control" id="gathAmount" name="gathAmount">
                                </div>
                            </div>
                                <div class="form-group" id="smarteditor" >
                                    <label for="gathContent">내용</label>
                                    <textarea class="form-control" id="gathContent" name="gathContent" rows="10" cols="10" placeholder="내용을 입력하세요" style="width: 100%;"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="gathFileList" class="btn btn-primary mr-2">파일추가</label>
                                    <input type="file" id="gathFileList" name="gathFileList" onchange="addFile()" style="appearance: none; -webkit-appearance: none; display: none"  multiple>
                                    <span style="font-size:10px;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>
                                    <div class="input-group col-xs-12">
                                        <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <div style="display: flex; float:right; margin-right: 20px;">
                                <input type="button" id="gathWriteBtn" name="gathWriteBtn" class="btn btn-primary mr-2" onclick="gathWrite()" value="작성">
                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소" onclick="location.href='/gathering/list?page=1&keyword='">
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
    let gathContent;
    let oEditors = [];

    //페이지 로딩시 필요한
    $(document).ready(function(){
        //  1. 스마트에디터
       // smartEditor();

        //2. 주소API
        document.getElementById('gathAddr').addEventListener('click', function () {
            new daum.Postcode({
                oncomplete: function (data) { //선택시 입력값 세팅
                    document.getElementById("gathAddr").value = data.address; // 주소 넣기
                    document.querySelector("input[name=gathAddr]").focus(); //상세입력 포커싱
                }
            }).open();
        })
    });
    function smartEditor(){
        nhn.husky.EZCreator.createInIFrame({
            oAppRef : oEditors,
            elPlaceHolder : "gathContent",
            sSkinURI: "/smartEditor/SmartEditor2Skin.html",
            fCreator: "createSEditor2"
        });
    }

    function insertContent() {
        oEditors.getById("gathContent").exec("UPDATE_CONTENTS_FIELD", []);
        if (gathContent === '') {
            alert('내용을 입력 해 주세요');
            oEditors.getById("gathContent").exec("FOCUS");
            return;
        } else {
            gathContent = $('gathContent').val();
            alert(gathContent);
        }
    }

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
                + '<img src="/static/images/icons/X.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;"/></span>'
                + '</div>';
        }
        $('#fileList').append(html);
    }

    //1. 파일추가
    function addFile(){
        //1.파일 갯수 확인
        fileArray2 = $('#gathFileList')[0].files;
        console.log('fileArray2 : ' + fileArray2);
        if(fileCount + fileArray2.length > maxCount){
            alert("파일을 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
            return;
        } else {
            fileCount = fileCount + fileArray2.length;
        }
        //fileArray = $('#gathFileList')[0].files;
        for(let i = 0 ; i < fileArray2.length ; i++){
            fileArray.push(fileArray2[i]);
        }
        console.log(fileArray);
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
        console.log(fileArray);
        fileArray2=[];
        changeView();
    }


    //3. 게시글 작성 --> 스마트에디터 내용 페이지에 널어주기:oEditors.getById is not a function
    function gathWrite() {
        // insertContent();    //스마트에디터
        let gathTitle = $('#gathTitle').val();
        gathContent = $('gathContent').val();
        let gathAddr = $('#gathAddr').val();
        let gathArrr2 = $('#gathAddr2').val();
        let gathDay = $('#gathDay').val();
        let gathClose = $('gathClose').val();
        let gathAmount = $('#gathAmount').val();
        let cityNo = $('#cityNo option:selected').val();
        let gathTypeNo = $('#gathTypeNo option:selected').val();

        if(gathTitle === ''){
            alert("제목을 입력하세요");
            document.getElementById("gathTitle").focus();
            return false;
        }
        if(gathContent === ''){
            alert("내용을 입력하세요");
            document.getElementById("gathContent").focus();
            return false;
        }
        if(gathDay === ''){
            alert("모임일을 입력하세요");
            document.getElementById("gathDay").focus();
            return false;
        }
        if(gathClose === ''){
            alert("모집마감일을 입력하세요");
            document.getElementById("gathClose").focus();
            return false;
        }
        if(gathDay <= gathClose){
            alert("모집일은 모집마감일 이후여야합니다.");
            document.getElementById("gathDay").focus();
            return false;
        }
        if(gathDay <= new Date() || gathClose <= new Date()){
            alert("모집일과 모집마감일은 현재날짜 이후여야합니다.");
            $('#gathDay').val('');
            $('#gathClose').val('');
            document.getElementById("gathDay").focus();
            return false;
        }
        if(cityNo === ''){
            alert("모임위치를 선택하세요");
            document.getElementById("cityNo").focus();
            return false;
        }
        if(gathAmount === ''){
            alert("모집인원을 선택하세요");
            document.getElementById("gathAmount").focus();
            return false;
        }
        if(gathTypeNo === ''){
            alert("모임유형을 선택하세요");
            document.getElementById("gathTypeNo").focus();
            return false;
        }

        let form = $('#gatheringWriteF').serializeArray();
        let formData = new FormData();
        //개별 값 하나씩 폼데이터에 붙여줘야함
        for(let i=0;i<form.length;i++){
            formData.append(form[i].name,form[i].value);
        }
        for (var i = 0; i < fileArray.length; i++) {
            formData.append("mfList", fileArray[i]);
        }
        $.ajax({
            url : '/gathering/register.ajx',
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
