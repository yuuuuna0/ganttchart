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
                                <form class="forms-sample" name="registerF" id="registerF">
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
                                            <label for="mId">아이디</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="mId" name="mId"
                                                   placeholder="아이디를 입력하세요.">
                                            <label for="mId" style="font-size: 8pt">&nbsp;&nbsp;5글자 이상 10글자 이하로 공백을 사용할 수 없습니다.</label>
                                        </div>
                                        <div class="col-3 mt-4">
                                            <label></label>
                                            <input type="button" value="중복확인" onclick="validateId()"
                                                   class="btn btn-primary mr-2">
                                        </div>
                                        <div class="col-3">
                                            <label for="mTypeNo">권한</label><span style="color: red;">*</span>
                                            <select class="form-control" id="mTypeNo" name="mTypeNo">
                                                <option disabled selected></option>
                                                <option value="1">일반회원</option>
                                                <option value="2">판매자</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="mPassword">비밀번호</label><span style="color: red;">*</span>
                                            <input type="password" class="form-control" id="mPassword" name="mPassword"
                                                   placeholder="비밀번호를 입력하세요">
                                            <label style="font-size: 8pt" for="mPassword">&nbsp;&nbsp;영문,특수문자,숫자를 포함하는 6글자 이상 12글자 이하로 공백을 사용할 수 없습니다.</label>
                                        </div>
                                        <div class="col-6">
                                            <label for="confirmPassword">비밀번호 확인</label><span style="color: red;">*</span>
                                            <input type="password" class="form-control" id="confirmPassword"
                                                   name="confirmPassword" placeholder="비밀번호 확인을 입력하세요">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="mName">이름</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="mName" name="mName"
                                                   placeholder="이름을 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="mGender">성별</label><span style="color: red;">*</span>
                                            <select class="form-control" id="mGender" name="mGender">
                                                <option disabled selected></option>
                                                <option value="남">남</option>
                                                <option value="여">여</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="mEmail">이메일</label><span style="color: red;">*</span>
                                        <input type="email" class="form-control" id="mEmail" name="mEmail"
                                               placeholder="이메일을 입력하세요">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="mPhone">전화번호</label>
                                            <input type="text" class="form-control" id="mPhone" name="mPhone"
                                                   placeholder="전화번호를 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="mBirth">생일</label>
                                            <input type="date" class="form-control" id="mBirth" name="mBirth">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="mAddr">주소</label>
                                            <input type="text" class="form-control" id="mAddr" name="mAddr"
                                                   placeholder="주소를 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="mAddr2">&nbsp;</label>
                                            <input type="text" class="form-control" id="mAddr2" name="mAddr2" placeholder="상세주소를 입력하세요">
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
        document.getElementById('mAddr').addEventListener('click', function () {
            new daum.Postcode({
                oncomplete: function (data) { //선택시 입력값 세팅
                    document.getElementById("mAddr").value = data.address; // 주소 넣기
                    document.querySelector("input[name=mAddr]").focus(); //상세입력 포커싱
                }
            }).open();
        })
    };
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
        let mId = $('#mId').val();
        //정규식 체크
        if (mId === '') {
            alert('아이디를 입력하세요');
            $('#mId').focus();
            return false;
        }
        if(mId.match(/\s/g)){
            alert("아이디는 공백을 사용할 수 없습니다.");
            $('#mId').val('');
            $('#mId').focus();
            return false;
        }
        if(mId.length <5 || mId.length >10){
            alert("아이디는 5글자 이상 10글자 이하입니다.");
            $('#mId').focus();
            return false;
        }
        $.ajax({
            url : '/member/idCheck-ajax',
            method : 'POST',
            data : {
                'mId' : mId
            },
            success : function(resultJson){
                console.log(resultJson);
                if(resultJson.code === 1){
                    alert("사용할 수 있는 아이디입니다");
                    $('#mId').value = mId;
                    vId=1;
                } else{
                    alert("중복된 아이디입니다.");
                    $('#mId').val('');
                    return false;
                }
            },
            error :function (e) {
                console.log(e);
            },
            async : true
        });
    }


    function createUser() {
        let mId = $('#mId').val();
        let mName = $('#mName').val();
        let mEmail = $('#mEmail').val();
        let mPassword = $('#mPassword').val();
        let mConfirmPassword = $('#confirmPassword').val();
        let mGender = $('#mGender option:selected').val();
        let mTypeNo = $('#mTypeNo option:selected').val();

        /**************************** 유효성 검사 ****************************************/
        if (vId === 0){
            alert("아이디 중복확인을 하세요");
            return false;
        }
        //1) 비밀번호 정규식 검사
        if (mPassword === '') {
            alert("비밀번호를 입력하세요");
            $('#mPassword').focus();
            return false;
        }
        if (mConfirmPassword === '') {
            alert("비밀번호 확인을 입력하세요");
            $('#confirmPassword').focus();
            return false;
        }
        if (mName === '') {
            alert("이름을 입력하세요");
            $('#mName').focus();
            return false;
        }
        if (mEmail === '') {
            alert("이메일을 입력하세요");
            $('#mEmail').focus();
            return false;
        }
        if (!mEmail.match(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i)){
            alert("이메일형식에 맞게 작성해주세요");
            $('#mEmail').val('');
            $('#mEmail').focus();
            return false;
        }
        if (mTypeNo === '') {
            alert("권한을 선택하세요");
            return false;
        }
        if (mGender === '') {
            alert("성별을 선택하세요");
            return false;
        }
        if (mPassword !== mConfirmPassword) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $('#mPassword').val('');
            $('#confirmPassword').val('');
            $('#confirmPassword').focus();
            return false;
        }

        let form = $('#registerF')[0];
        let formData = new FormData(form);
        //formData.append($('#photoFile')[0].files);

        $.ajax({
            url : '/member/register-ajax',
            method : 'POST',
            contentType : false,
            processData : false,
            data : formData,
            success : function(resultJson){
                console.log(resultJson);
                if(resultJson.code === 1){
                    window.location.href=resultJson.forwardPath;
                } else {
                    alert(resultJson.msg);
                }
            },
            error : function(e){
                console.log(e)
            }
        });
    }
</script>

</body>
</html>