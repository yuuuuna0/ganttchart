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
                <div class="col-12 grid-margin">
                    <div class="card">
                        <div class="card-body">
                            <form id="reviewF" name="reviewF">
                            <h4 class="card-title">모임 후기 작성하기</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">모임명</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="${gathering.gathTitle}" disabled />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">모임타입</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="${gathering.gatheringType.gathType}" disabled />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">모임지역</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="${gathering.city.city}" disabled />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">모임일</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="<fmt:formatDate value="${gathering.gathDay}" pattern="yyyy. MM. dd."/>" disabled />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">평점</label>
                                            <div class="col-sm-9">
                                                        <select id="ratingSelect" name="ratingSelect">
                                                            <option value="0">0</option>
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                        </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group row">
                                            <label class="col-sm-1 col-form-label">리뷰</label>
                                            <div class="col-sm-11" style="padding-left: 50px;">
                                                <textarea class="form-control" id="reviewContent" name="reviewContent" rows="4" placeholder="모임 후기를 작성해주세요"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div><div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group row">
                                            <div class="form-group">
                                                <label for="reviewFileList" class="btn btn-primary mr-2">파일추가</label>
                                                <input type="file" id="reviewFileList" name="reviewFileList" onchange="addFile()" style="appearance: none; -webkit-appearance: none; display: none"  multiple>
                                                <span style="font-size:10px;">※첨부파일은 최대 5개까지 등록이 가능합니다.</span>
                                                <div class="input-group col-xs-12">
                                                    <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <div style="display: flex; float:right; margin-right: 20px;">
                                <input type="button" id="reviewWriteBtn" name="reviewWriteBtn" class="btn btn-primary mr-2" onclick="reviewWrite()" value="작성">
                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소" onclick="location.href='/user/applyList?uId=${sessionScope.loginUser.getUId()}'">
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
    </div>
    <!-- main-panel ends -->
<script>
    <%--// 1. 별점 선택 --> 안먹는중--%>
    <%--const rating_input = document.querySelector('.rating input');--%>
    <%--const rating_star = document.querySelector('.rating_star');--%>
    <%--rating_input.addEventListener('input', () => {--%>
    <%--    rating_star.style.width = `${rating_input.value * 10}%`;--%>
    <%--});--%>


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
                    + '&nbsp;<img src="/static/images/icons/X.png" style="width:10px; height:auto; vertical-align: middle; cursor: pointer;"/></span>'
                    + '</div>';
            }
            $('#fileList').append(html);
        }

        //1. 파일추가
        function addFile(){
            //1.파일 갯수 확인
            fileArray2 = $('#reviewFileList')[0].files;
            //확장자 검사
            for(let i=0;i<fileArray2.length;i++){
                let str = fileArray2[i].name;
                var fileName = str.split('\\').pop().toLowerCase();
                var ext =  fileName.split('.').pop().toLowerCase();
                let allowedExt = ['jpg', 'png', 'jpeg', 'gif','bmp'];
                if(allowedExt.indexOf(ext) === -1){
                    alert(ext+'파일은 업로드 하실 수 없습니다.');
                    return false;
                }
            }

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
            --fileCount;
            fileArray2=[];
            changeView();
        }

    //리뷰 남기기
    function reviewWrite(){
        let reviewContent = $('#reviewContent').val();
        let gathNo = ${gathering.gathNo};
        let reviewRating = $('#ratingSelect option:selected').val();
        console.log(reviewRating);
        if(reviewContent === ''){
            alert("모임 후기를 작성해주세요");
            $('#reviewContent').focus();
            return false;
        }
        if(reviewRating === 0){
            alert("평점을 입력 해주세요");
            return false;
        }
        let formData = new FormData();
        // let form = $('#reviewF').serializeArray();
        // for(let i=0;i<form.length;i++){
        //     formData.append(form[i].name,form[i].value);
        // }
        formData.append("gathNo",gathNo);
        formData.append("reviewRating",reviewRating);
        formData.append("reviewContent",reviewContent);
        for(let i=0;i<fileArray.length;i++){
            formData.append("mfList",fileArray[i]);
        }
        $.ajax({
            url : '/gathering/review/register.ajx',
            method : 'POST',
            contentType : false,
            processData : false,
            data : formData,
            success : function(resultMap){
                if(resultMap.code === 1){
                    let result = confirm(resultMap.msg);
                    if(result){
                        window.location.href=resultMap.forwardPath;
                    }
                } else{
                    alert(resultMap.msg);
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }






</script>
