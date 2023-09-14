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
                                <h4 class="card-title">회원가입</h4>
                                <form class="forms-sample" name="registerF" id="registerF" enctype="multipart/form-data">
                                    <!-- 프로필사진 업로드 -->
                                    <div class="form-group" style="text-align: center">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/static/images/icons/default.png"/>
                                        <br>
                                        <br>
                                        <label for="photoFile" class="file-upload-browse btn btn-primary">사진 추가</label>
                                        <input type="file"  id="photoFile" name="photoFile" accept="img/*" style="display: none;" onchange="uploadPhoto(this)">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uId">아이디</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="uId" name="uId"
                                                   placeholder="아이디를 입력하세요.">
                                            <label for="uId" style="font-size: 8pt">&nbsp;&nbsp;5글자 이상 10글자 이하로 공백을 사용할 수 없습니다.</label>
                                        </div>
                                        <div class="col-3 mt-4">
                                            <label></label>
                                            <input type="button" value="중복확인" onclick="validateId()"
                                                   class="btn btn-primary mr-2">
                                        </div>
                                        <div class="col-3">
                                            <label for="uTypeNo">회원 권한</label><span style="color: red;">*</span>
                                            <select class="form-control" id="uTypeNo" name="uTypeNo">
                                                <option disabled selected></option>
                                                <option value="1">일반회원</option>
                                                <option value="2">판매자</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uPassword">비밀번호</label><span style="color: red;">*</span>
                                            <input type="password" class="form-control" id="uPassword" name="uPassword"
                                                   placeholder="비밀번호를 입력하세요">
                                            <label style="font-size: 8pt" for="uPassword">&nbsp;&nbsp;영문,특수문자,숫자를 포함하는 6글자 이상 12글자 이하로 공백을 사용할 수 없습니다.</label>
                                        </div>
                                        <div class="col-6">
                                            <label for="confirmPassword">비밀번호 확인</label><span style="color: red;">*</span>
                                            <input type="password" class="form-control" id="confirmPassword"
                                                   name="confirmPassword" placeholder="비밀번호 확인을 입력하세요">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uName">이름</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="uName" name="uName"
                                                   placeholder="이름을 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="uGender">성별</label><span style="color: red;">*</span>
                                            <select class="form-control" id="uGender" name="uGender">
                                                <option disabled selected></option>
                                                <option value="남">남</option>
                                                <option value="여">여</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="uEmail">이메일</label><span style="color: red;">*</span>
                                        <input type="email" class="form-control" id="uEmail" name="uEmail"
                                               placeholder="이메일을 입력하세요">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uPhone">전화번호</label>
                                            <input type="text" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" class="form-control" id="uPhone" name="uPhone"
                                                   placeholder="전화번호를 입력하세요">
                                            <label style="font-size: 8pt" for="uPhone">&nbsp;&nbsp;'-'를 제외한 숫자만 입력하세요</label>
                                        </div>
                                        <div class="col-6">
                                            <label for="uBirth">생일</label>
                                            <input type="date" class="form-control" id="uBirth" name="uBirth">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uAddress">주소</label>
                                            <input type="text" class="form-control" id="uAddress" name="uAddress"
                                                   placeholder="주소를 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="uAddress2">&nbsp;</label>
                                            <input type="text" class="form-control" id="uAddress2"
                                                   name="uAddress2" placeholder="상세주소를 입력하세요">
                                        </div>
                                    </div>
                                    <div style="text-align:center;">
                                        <input type="button" onclick="createUser()" class="btn btn-primary mr-2"
                                               value="회원가입">
                                        <input type="button" class="btn btn-light" value="취소"
                                               onclick="location.href='/login'">
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
    // //2. birth -> datepicker 이용
    // window.onload = function () {
    //     $("#birth").datepicker({dateFormat: 'yyyy-MM-dd'});    //시간되면 년도 옮기는 옵션 추가하기
    // };

    //3. 파일 업로드시 이미지 보여주기
    function uploadPhoto(input){
        if(input.files && input.files[0]){
            var reader = new FileReader();
            reader.onload = function(e){
                document.getElementById("prevPhoto").src=e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    //4. 아이디 정규식 체크 및 중복검사
    let vId= 0;
    function validateId(){
        let id = $('#uId').val();
        //정규식 체크
        if (id === '') {
            alert('아이디를 입력하세요');
            $('#uId').focus();
            return false;
        }
        if(id.match(/\s/g)){
            alert("아이디는 공백을 사용할 수 없습니다.");
            $('#uId').val('');
            $('#uId').focus();
            return false;
        }
        if(id.length <5 || id.length >10){
            alert("아이디는 5글자 이상 10글자 이하입니다.");
            $('#uId').focus();
            return false;
        }
        $.ajax({
            url : '/user/idCheck',
            method : 'POST',
            data : {
                'id' : id
            },
            success : function(resultJson){
                if(resultJson.code === 1){
                    alert(resultJson.msg);
                    $('#uId').value = id;
                    vId=1;
                } else{
                    alert(resultJson.msg);
                    $('#uId').val('');
                    return false;
                }
            },
            error :function (e) {
                console.log(e);
            }
        });
    }

    function createUser() {
        let uId = $("#uId").val();
        let uName = $("#uName").val();
        let uEmail = $("#uEmail").val();
        let uPassword = $("#uPassword").val();
        let confirmPassword = $("#confirmPassword").val();
        let uGender = $('#uGender option:selected').val();
        let uTypeNo = $('#uTypeNo option:selected').val();
        let uPhone = $('#uPhone').val();

        /**************************** 유효성 검사 ****************************************/
        if (vId === 0){
            alert("아이디 중복확인을 하세요");
            return false;
        }
        if (uId === '') {
            alert("아이디를 입력하세요");
            $("#uId").focus();
            return false;
        }
        if (uPassword === '') {
            alert("비밀번호를 입력하세요");
            $("#uPassword").focus();
            return false;
        }
        if (confirmPassword === '') {
            alert("비밀번호 확인을 입력하세요");
            $("#confirmPassword").focus();
            return false;
        }
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
        if(uPhone !== '' && uPhone.match(/^01([0-9]{8,9})$/)){
            //010도 자꾸 넘어감
            alert("전화번호 양식에 맞게 입력 해 주세요");
            $('#uPhone').val();
            $("#uPhone").focus();
            return false;
        }
        if (uTypeNo === '') {
            alert("회원등급을 선택하세요");
            return false;
        }
        if (uGender === '') {
            alert("성별을 선택하세요");
            return false;
        }
        if (uPassword !== confirmPassword) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $('#uPassword').val('');
            $('#confirmPassword').val('');
            $("#confirmPassword").focus();
            return false;
        }


        let form = $('#registerF').serializeArray();
        let file = $('#photoFile')[0].files;
        let formData = new FormData();
        for(let i=0;i<form.length;i++){
            formData.append(form[i].name,form[i].value);
        }
        formData.append("file",file[0]);
        for(let data of formData){
            console.log(data);
        }

        $.ajax({
            url : '/user/register.ajx',
            method : 'POST',
            data : formData,
            contentType : false,
            processData : false,    //필요여부 확인
            success : function(resultJson){
                alert(resultJson.msg);
                if(resultJson.code === 1){
                    window.location.href = resultJson.forwardPath;
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }
</script>
