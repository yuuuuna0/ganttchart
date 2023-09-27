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
                        <div class="card-body">
                            <h4 class="card-title">회원수정</h4>
                            <form class="forms-sample" name="modifyF" id="modifyF" enctype="multipart/form-data">
                            <!-- 프로필사진 업로드 -->
                            <div class="form-group" style="text-align: center">
                                <c:if test = "${ file != null}">
                                    <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/upload/user/${file.saveName}"/>
                                </c:if>
                                <c:if test = "${ file == null}">
                                    <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/static/images/icons/default.png"/>
                                </c:if>
                                <br>
                                <br>
                                <label for="photoFile" class="file-upload-browse btn btn-primary">사진 변경</label>
                                <input type="file"  id="photoFile" name="photoFile" accept="img/*" style="display: none;" onchange="uploadPhoto(this)">
                            </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                    <label for="uId">아이디</label>
                                    <input readonly  type="text" class="form-control" id="uId" name="uId" value="${user.getUId()}">
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-4">
                                        <label for="uPassword">비밀번호</label>
                                        <input readonly type="password" class="form-control" id="uPassword" name="uPassword" value="xxxxx" >
                                    </div>
                                    <div class="col-2 mt-auto">
                                        <input type="button" class="btn btn-primary mr-2" id="passwordBtn" name="passwordBtn" value="비밀번호 변경" onclick="location.href='/user/modifyPassword'" >
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="uName">이름</label>
                                        <input  type="text" class="form-control" id="uName" name="uName" value="${user.getUName()}">
                                    </div>
                                    <div class="col-6">
                                        <label for="uGender">성별</label>
                                        <select class="form-control" id="uGender" name="uGender">
                                            <c:choose>
                                                <c:when test="${user.getUGender() == '남'}">
                                                <option value="남" selected>남</option>
                                                <option value="여">여</option>
                                                </c:when>
                                                <c:when test="${user.getUGender() == '여'}">
                                                <option value="남" >남</option>
                                                <option value="여" selected>여</option>
                                                </c:when>
                                            </c:choose>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="uEmail">이메일</label>
                                    <input  type="email" class="form-control" id="uEmail" name="uEmail" value="${user.getUEmail()}">
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="uPhone">전화번호</label>
                                        <input  type="text" class="form-control" id="uPhone" name="uPhone" value="${user.getUPhone()}">
                                    </div>
                                    <div class="col-6">
                                        <label for="uBirth">생일</label>
                                        <input type="date" class="form-control" id="uBirth" name="uBirth"/>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="uAddress">주소</label>
                                        <input type="text" class="form-control" id="uAddress" name="uAddress" value="${user.getUAddress()}">
                                    </div>
                                    <div class="col-6">
                                        <label for="uAddress2">&nbsp;</label>
                                        <input type="text" class="form-control" id="uAddress2"
                                               name="uAddress2" value="${user.getUAddress2()}">
                                    </div>
                                </div>
                                <div style="text-align:center;">
                                    <input type="button" id="modifyUserBtn" class="btn btn-primary mr-2" value="수정완료" onclick="modifyUser();">
                                    <input type="button" id="cancelBtn" class="btn btn-light" value="취소"  onclick="location.href='/member/detail'">
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



<script type="text/javascript">
    // 생일 양식에 맞게 넣기
    <%--let uBirthStr = '${user.getUBirth()}';--%>
    <%--let dateParts = uBirthStr.split(' ');--%>
    <%--let year = dateParts[5];--%>
    <%--let month = (['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'].indexOf(dateParts[1]) + 1).toString().padStart(2, '0');--%>
    <%--let day = dateParts[2];--%>
    <%--uBirthStr = year+'-'+month+'-'+day;--%>
    <%--let uBirth = new Date(uBirthStr);--%>

    //1. 주소 api
    window.onload = function () {
        document.getElementById('uAddress').addEventListener('click', function () {
            new daum.Postcode({
                oncomplete: function (data) { //선택시 입력값 세팅
                    document.getElementById("uAddress").value = data.address; // 주소 넣기
                    document.querySelector("input[name=uAddress]").focus(); //상세입력 포커싱
                }
            }).open();
        })
    };
    // //2. birth -> datepicker 이용해야 생일 양식에 넣을 수 있을듯
    // window.onload = function () {
    //     $("#uBirth").datepicker({dateFormat: 'yyyy-MM-dd'});    //시간되면 년도 옮기는 옵션 추가하기
    // };

    //3. 파일 업로드시 이미지 보여주기
    function uploadPhoto(input){
        //확장자 검사
        let str = $('#photoFile').val();
        var fileName = str.split('\\').pop().toLowerCase();
        var ext =  fileName.split('.').pop().toLowerCase();
        let allowedExt = ['jpg', 'png', 'jpeg', 'gif','bmp'];
        if(allowedExt.indexOf(ext) === -1){
            alert(ext+'파일은 업로드 하실 수 없습니다.');
            return false;
        }
        if(input.files && input.files[0]){
            var reader = new FileReader();
            reader.onload = function(e){
                document.getElementById("prevPhoto").src=e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    //3.
    function modifyUser(){
        let uName = $("#uName").val();
        let uEmail = $("#uEmail").val();
        let uGender = $('#uGender option:selected').val();
        let uPhone = $('#uPhone').val();
        // let uBirth = $('#uBirth').val();

        if (uName === '') {
            alert("이름을 입력하세요");
            $("#uName").focus();
            return false;
        }
        if (uEmail === '') {
            alert("이메일을 입력하세요");
            $("#uEmail").focus();
            return false;
        }
        if (!uEmail.match(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i)){
            alert("이메일형식에 맞게 작성해주세요");
            $('#uEmail').val('');
            $("#uEmail").focus();
            return false;
        }
        if (uGender === '') {
            alert("성별을 선택하세요");
            return false;
        }
        <%--if(uBirth === ''){--%>
        <%--    uBirth = ${user.getUBirth()}--%>
        <%--}--%>
        //전화번호 정규식
        // let result1 = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
        // if(!result1.test(uPhone)){
        //     alert("전화번호 양식에 맞게 입력 해 주세요");
        //     $('#uPhone').val();
        //     $("#uPhone").focus();
        //     return false;
        // }

        let form = $('#modifyF').serializeArray();
        let file = $('#photoFile')[0].files;

        let formData = new FormData();
        for(let i=0;i<form.length;i++){
            formData.append(form[i].name,form[i].value);
        }
        formData.append("mf",file[0]);
        $.ajax({
            url : '/user/modify.ajx',
            method : 'POST',
            data : formData,
            contentType : false,
            processData : false,    //필요여부 확인
            success : function(resultJson){
                if(resultJson.code === 1){
                    window.location.href = resultJson.forwardPath;
                } else{
                    alert(resultJson.msg);
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }

</script>
