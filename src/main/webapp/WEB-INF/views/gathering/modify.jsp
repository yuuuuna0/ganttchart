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
                    <form id="modifyF" name="mofidyF">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-8">
                                <h4 class="card-title">모임 수정하기</h4>
                            </div>
                            <div class="col-4 flex" style="display: flex; justify-content: flex-end;">
                                    <input type="button" id="gathCreateBtn" name="gathCreateBtn"
                                           class="btn btn-primary mr-2"
                                           onclick="modifyGath()" value="수정완료">
                                    <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light"
                                           onclick="location.href='/gathering/delete.action?gathNo=${gath.gathNo}'" value="삭제">
                                    <input type="button" id="listBtn" name="listBtn" class="btn btn-primary ml-2"
                                              onclick="location.href='/gathering/list?pageNo=1&keyword='" value="목록으로">
                            </div>
                        </div>
                        <br>
                        <div class="form-group row">
                            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-indicators">
                                    <c:forEach items="${fileList}" varStatus="no">
                                        <c:choose>
                                        <c:when test="${no.index == 0}">
                                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${no.index}" class="active" aria-current="true" aria-label="Slide ${no.index}"></button>
                                        </c:when>
                                        <c:otherwise>
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${no.index}" aria-label="Slide ${no.index}"></button>
                                        </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <div class="carousel-inner">
                                    <c:forEach items="${fileList}" var="file">
                                    <div class="carousel-item active">
                                        <img src="/upload/gathering/${file.saveName}" style="width: 50%; height: 500px;  object-fit: cover;" class="d-block w-100" alt="...">
                                    </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-6">
                            <label for="gathTitle">제목</label>
                            <input type="text"  class="form-control" id="gathTitle" name="gathTitle"
                                   value="${gath.gathTitle}" >
                            </div>
                            <div class="col-6">
                                <label for="readCount">조회수</label>
                                <input  type="text" class="form-control" id="readCount" name="readCount"
                                       value="${gath.gathReadcount}" disabled>
                            </div>
                        </div>
                        <div class="form-group row" >
                            <div class="col-6">
                            <label for="name">작성자</label>
                            <input  type="text" class="form-control" id="name" name="name"
                                   value="${gath.getUId()}" disabled>
                            </div>
                            <div class="col-6">
                            <label for="date">작성일</label>
                            <input  type="text" class="form-control" id="date" name="date"
                                   value="<fmt:formatDate value="${gath.gathCreateDate}" pattern="yyyy. MM. dd."/>" disabled >
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-6">
                                <label for="cityNo">지역</label><span style="color: red;">*</span>
                                <select class="form-control" id="cityNo" name="cityNo">
                                    <c:forEach items="${cityList}" var="city">
                                        <c:choose>
                                            <c:when test="${gath.cityNo == city.cityNo}">
                                                <option value="${city.cityNo}" selected>${city.city}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${city.cityNo}">${city.city}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-6">
                                <label for="gathTypeNo">카테고리</label><span style="color: red;">*</span>
                                <select class="form-control" id="gathTypeNo" name="gathTypeNo">
                                    <c:forEach items="${gathTypeList}" var="gathType">
                                    <c:choose>
                                        <c:when test="${gath.gathTypeNo == gathType.gathTypeNo}">
                                            <option value="${gathType.gathTypeNo}" selected>${gathType.gathType}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${gathType.gathTypeNo}">${gathType.gathType}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row" >
                            <div class="col-6">
                                <label for="gathAddr">주소</label>
                                <input type="text" class="form-control" id="gathAddr" name="gathAddr" onclick="addGathAddr()" value="${gath.gathAddr}">
                            </div>
                            <div class="col-6">
                                <label for="gathAddr2">&nbsp;</label>
                                <input type="text" class="form-control" id="gathAddr2" name="gathAddr2" value="${gath.gathAddr2}">
                            </div>
                        </div>
                        <div class="form-group row" >
                            <div class="col-3">
                            <label for="gathDay">모임일</label>
                            <input  type="date" class="form-control" id="gathDay" name="gathDay"
                                     value='<fmt:formatDate value="${gath.gathDay}" pattern="yyyy. MM. dd."/>'  >
                            </div>
                            <div class="col-3">
                            <label for="gathClose">모집마감일</label>
                            <input  type="date" class="form-control" id="gathClose" name="gathClose"
                                    value='<fmt:formatDate value="${gath.gathClose}" pattern="yyyy. MM. dd."/>'  >
                            </div>
                            <div class="col-3">
                            <label for="gathAmount">모집인원</label>
                            <input  type="number" class="form-control" id="gathAmount" name="gathAmount"
                                   value="${gath.gathAmount}" >
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-6">
                            <label for="gathDesc">내용</label>
                            <textarea class="form-control" id="gathDesc" name="gathDesc" rows="10"
                                      >${gath.gathDesc}</textarea>
                                <br>
                                <label for="gathFileList" class="btn btn-primary" style="padding: 5px 10px;">파일추가</label>
                                <input type="file" id="gathFileList" name="gathFileList" onchange="addFile()" style="appearance: none; -webkit-appearance: none; display: none"  multiple>
                                <span style="font-size:10px;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>
                                <div class="input-group col-xs-12">
                                    <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                        <c:forEach items="${gath.fileList}" var="file">
                                            <div class="existedFile" id="file${file.fileNo}" style="font-size:12px;" onclick="deleteTextFile(${file.fileNo})">
                                                <span class="nameList">${file.originalName}</span>&nbsp<span><img src="/static/images/icons/X.png" style="width:10px; height:auto; vertical-align: middle; cursor: pointer;"> </span>
                                            </div>
                                        </c:forEach>
                                        <div id="fileList2">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6" id="map" style="width:500px;height:400px;">
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- content-wrapper ends -->
</div>
<!-- main-panel ends -->
<script>
    // 날짜 양식에 맞게 넣기
    let rawGathDay = $('#gathDay').val();
    let gathDay = new Date(rawGathDay).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '-');
    $('#gathDay').val(gathDay);
    let rawGathClose = $('#gathClose').val();
    let gathClose = new Date(rawGathClose).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '-');
    $('#gathClose').val(gathClose);


    //1. 주소API
    function addGathAddr(){
        new daum.Postcode({
            oncomplete: function (data) { //선택시 입력값 세팅
                document.getElementById("gathAddr").value = data.address; // 주소 넣기
                document.querySelector("input[name=gathAddr]").focus(); //상세입력 포커싱
                checkMaps(data.address);
            }
        }).open();
    }
    //카카오 지도 출력
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스.
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
        level: 3 //지도의 레벨(확대, 축소 정도)
    };
    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var geocoder = new kakao.maps.services.Geocoder();  // 주소-좌표 변환 객체를 생성합니다
    let addr = '${gath.gathAddr}';
    geocoder.addressSearch(addr, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
            map.setCenter(coords);
        }
    });


    let fileCount = $('.existedFile').length;// 파일 현재 필드 숫자 -> maxCount와 비교
    console.log(fileCount);
    let maxCount = 5;     // 최대 첨부 갯수
    let fileArray = [];
    let fileArray2 = [];
    //기존 파일 지우기
    function deleteTextFile(no){
        $('#file'+no).remove();
        --fileCount;
        console.log(fileCount);
    }
    //파일업로드
    function changeView(){
        $('#fileList2').empty();
        let html = '';
        for(let i=0;i<fileArray.length;i++){
            html+=  '<div id="file' + i + '" style="font-size:12px;" onclick="deleteFile( ' + i + ')">'
                + fileArray[i].name
                + '&nbsp;<img src="/static/images/icons/X.png" style="width:10px; height:auto; vertical-align: middle; cursor: pointer;"/></span>'
                + '</div>';
        }
        $('#fileList2').append(html);
    }

    //1. 파일추가
    function addFile(){
        //1.파일 갯수 확인
        fileArray2 = $('#gathFileList')[0].files;
        if(fileCount + fileArray2.length > maxCount){
            alert("파일은 최대 "+maxCount+"개까지 업로드 할 수 있습니다.");
            return;
        } else {
            fileCount = fileCount + fileArray2.length;
        }
        //fileArray = $('#gathFileList')[0].files;
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
        console.log(fileArray);
        fileArray2=[];
        --fileCount;
        changeView();
    }

    //3. 모임수정
    function modifyGath() {
        let gathNo = ${gath.gathNo};
        console.log(gathNo);
        let gathTitle = $('#gathTitle').val();
        let gathDesc = $('#gathDesc').val();
        let gathAddr = $('#gathAddr').val();
        let gathArrr2 = $('#gathAddr2').val();
        let gathDay = new Date($('#gathDay').val());
        let gathClose = new Date($('#gathClose').val());
        let gathAmount = $('#gathAmount').val();
        let cityNo = $('#cityNo option:selected').val();
        let gathTypeNo = $('#gathTypeNo option:selected').val();

        if(gathTitle === ''){
            alert("제목을 입력하세요");
            document.getElementById("gathTitle").focus();
            return false;
        }
        if(gathDesc === ''){
            alert("내용을 입력하세요");
            document.getElementById("gathDesc").focus();
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
        let today= new Date();
        if(gathDay <= today || gathClose <= today){
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

        let form = $('#modifyF').serializeArray();
        let formData = new FormData();
        formData.append("gathNo",gathNo);
        //개별 값 하나씩 폼데이터에 붙여줘야함
        for(let i=0;i<form.length;i++){
            formData.append(form[i].name,form[i].value);
        }
        for (var i = 0; i < fileArray.length; i++) {
            formData.append("mfList", fileArray[i]);
        }
        let nameList=[];
        $('.nameList').each(function() {
            nameList.push($(this).text());
        });
        formData.append("nameList",nameList);

        $.ajax({
            url : '/gathering/modify.ajx',
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