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
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="../images/icons/default.png"/>
                                        <br>
                                        <br>
                                        <label for="photoFile" class="file-upload-browse btn btn-primary">사진 추가</label>
                                        <input type="file"  id="photoFile" name="photoFile" accept="img/*" style="display: none;" onchange="uploadPhoto(this)">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="id">아이디</label>
                                            <input type="text" class="form-control" id="id" name="id"
                                                   placeholder="아이디를 입력하세요">
                                        </div>
                                        <div class="col-6 mt-4">
                                            <label></label>
                                            <input type="button" value="중복확인" onclick="validateId()"
                                                   class="btn btn-primary mr-2">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="password">비밀번호</label>
                                            <input type="password" class="form-control" id="password" name="password"
                                                   placeholder="비밀번호를 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="confirmPassword">비밀번호 확인</label>
                                            <input type="password" class="form-control" id="confirmPassword"
                                                   name="confirmPassword" placeholder="비밀번호 확인을 입력하세요">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="name">이름</label>
                                            <input type="text" class="form-control" id="name" name="name"
                                                   placeholder="이름을 입력하세요">
                                        </div>
                                        <div class="col-6">
                                            <label for="gender">성별</label>
                                            <select class="form-control" id="gender" name="gender">
                                                <option value="1">남</option>
                                                <option value="2">여</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">이메일</label>
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

    function createUser() {
        var id = document.getElementById("id").value;
        var name = document.getElementById("name").value;
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var phone = document.getElementById("phone").value;
        var address = document.getElementById("address").value + document.getElementById("detailedAddress").value;
        $('#address').val(address);
        var gender = 0;
        var birth = document.getElementById("birth").value;

        /**************************** 유효성 검사 ****************************************/
        if (id === '') {
            document.getElementById("id").innerText = '아이디를 입력하세요';
            document.getElementById("id").focus();
            return false;
        }
        if (password === '') {
            document.getElementById("passwordVal").innerText = "비밀번호를 입력하세요";
            document.getElementById("password").focus();
            return false;
        }
        if (confirmPassword === '') {
            document.getElementById("confirmPasswordVal").innerText = "비밀번호 확인을 입력하세요";
            document.getElementById("confirmPassword").focus();
            return false;
        }
        if (name === '') {
            document.getElementById("nameVal").innerText = "이름을 입력하세요";
            document.getElementById("name").focus();
            return false;
        }

        if (email === '') {
            document.getElementById("emailVal").innerText = "이메일을 입력하세요";
            document.getElementById("email").focus();
            return false;
        }
        if (phone === '') {
            document.getElementById("phoneVal").innerText = "전화번호를 입력하세요";
            document.getElementById("phone").focus();
            return false;
        }
        if (password !== confirmPassword) {
            document.getElementById("confirmPasswordVal").innerText = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
            document.getElementById("confirmPassword").focus();
            return false;
        }

        document.registerF.method = 'POST';
        document.registerF.action = '/user/register-action';
        document.registerF.submit();

    }
</script>

</body>
</html>