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
                                            <label for="id">아이디</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="id" name="id"
                                                   placeholder="아이디를 입력하세요.">
                                            <label for="id" style="font-size: 8pt">&nbsp;&nbsp;5글자 이상 10글자 이하로 공백을 사용할 수 없습니다.</label>
                                        </div>
                                        <div class="col-3 mt-4">
                                            <label></label>
                                            <input type="button" val()="중복확인" onclick="validateId()"
                                                   class="btn btn-primary mr-2">
                                        </div>
                                        <div class="col-3">
                                            <label for="grade">권한</label><span style="color: red;">*</span>
                                            <select class="form-control" id="grade" name="grade">
                                                <option disabled selected></option>
                                                <option value="1">일반회원</option>
                                                <option value="2">판매자</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="password">비밀번호</label><span style="color: red;">*</span>
                                            <input type="password" class="form-control" id="password" name="password"
                                                   placeholder="비밀번호를 입력하세요">
                                            <label style="font-size: 8pt" for="password">&nbsp;&nbsp;영문,특수문자,숫자를 포함하는 6글자 이상 12글자 이하로 공백을 사용할 수 없습니다.</label>
                                        </div>
                                        <div class="col-6">
                                            <label for="confirmPassword">비밀번호 확인</label><span style="color: red;">*</span>
                                            <input type="password" class="form-control" id="confirmPassword"
                                                   name="confirmPassword" placeholder="비밀번호 확인을 입력하세요">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="name">이름</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="name" name="name"
                                                   placeholder="이름을 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="gender">성별</label><span style="color: red;">*</span>
                                            <select class="form-control" id="gender" name="gender">
                                                <option disabled selected></option>
                                                <option value="남">남</option>
                                                <option value="여">여</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">이메일</label><span style="color: red;">*</span>
                                        <input type="email" class="form-control" id="email" name="email"
                                               placeholder="이메일을 입력하세요">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="phone">전화번호</label>
                                            <input type="text" class="form-control" id="phone" name="phone"
                                                   placeholder="전화번호를 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="birth">생일</label>
                                            <input type="date" class="form-control" id="birth" name="birth">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="address">주소</label>
                                            <input type="text" class="form-control" id="address" name="address"
                                                   placeholder="주소를 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="detailedAddress">&nbsp;</label>
                                            <input type="text" class="form-control" id="detailedAddress"
                                                   name="detailedAddress" placeholder="상세주소를 입력하세요">
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
        document.getElementById('address').addEventListener('click', function () {
            new daum.Postcode({
                oncomplete: function (data) { //선택시 입력값 세팅
                    document.getElementById("address").value = data.address; // 주소 넣기
                    document.querySelector("input[name=address]").focus(); //상세입력 포커싱
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
        let id = $('#id').val();
        //정규식 체크
        if (id === '') {
            alert('아이디를 입력하세요');
            $('#id').focus();
            return false;
        }
        if(id.match(/\s/g)){
            alert("아이디는 공백을 사용할 수 없습니다.");
            $('#id').val('');
            $('#id').focus();
            return false;
        }
        if(id.length <5 || id.length >10){
            alert("아이디는 5글자 이상 10글자 이하입니다.");
            $('#id').focus();
            return false;
        }
        $.ajax({
            url : '/member/idCheck-ajax',
            method : 'POST',
            data : {
                'id' : id
            },
            success : function(resultJson){
                console.log(resultJson);
                if(resultJson.code === 1){
                    alert("사용할 수 있는 아이디입니다");
                    $('#id').value = id;
                    vId=1;
                } else{
                    alert("중복된 아이디입니다.");
                    $('#id').val('');
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
        var mIdd = $('#id').val();
        var mName = $('#name').val();
        var mEmail = $('#email').val();
        var mPassword = $('#password').val();
        var mConfirmPassword = $('#confirmPassword').val();
        var mPhone = $('#phone').val();
        let mAddr = $('#address').val();
        let mAddr2 = $('#detailedAddress').val();
        let mGender = $('#gender option:selected').val();
        let mTypeNo = $('#grade option:selected').val();
        let mBirth = $('#birth').val();

        /**************************** 유효성 검사 ****************************************/
        if (vId === 0){
            alert("아이디 중복확인을 하세요");
            return false;
        }
        //1) 비밀번호 정규식 검사
        if (mPassword === '') {
            alert("비밀번호를 입력하세요");
            $('#password').focus();
            return false;
        }
        if (mConfirmPassword === '') {
            alert("비밀번호 확인을 입력하세요");
            $('#confirmPassword').focus();
            return false;
        }
        if (mName === '') {
            alert("이름을 입력하세요");
            $('#name').focus();
            return false;
        }
        if (mEmail === '') {
            alert("이메일을 입력하세요");
            $('#email').focus();
            return false;
        }
        if (!mEmail.match(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i)){
            alert("이메일형식에 맞게 작성해주세요");
            $('#email').val('');
            $('#email').focus();
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
            $('#password').val('');
            $('#confirmPassword').val('');
            $('#confirmPassword').focus();
            return false;
        }

        document.registerF.method = 'POST';
        document.registerF.action = '/member/register-action';
        document.registerF.submit();

    }
</script>

</body>
</html>