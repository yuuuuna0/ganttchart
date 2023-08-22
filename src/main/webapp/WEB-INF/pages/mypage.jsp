<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Skydash Admin</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="../../vendors/feather/feather.css">
    <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="../../vendors/select2/select2.min.css">
    <link rel="stylesheet" href="../../vendors/select2-bootstrap-theme/select2-bootstrap.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="../../images/favicon.png" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <jsp:include page="include/navbar.jsp"/>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->
        <jsp:include page="include/settings-panel.jsp"/>
        <!-- partial -->
        <!-- partial:partials/_sidebar.html -->
        <jsp:include page="include/sidebar.jsp"/>
        <!-- partial -->
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">회원가입</h4>
                            <!-- 프로필사진 업로드 -->
                            <div class="row form-group">
<%--                                <img id="prevPhoto" style="width: 500px; height:500px; "/>--%>
                                <input type="file" id="photoFile" name="photoFile" accept="img/*">
<%--                                <input class="file-upload-browse btn btn-primary" type="button" name="photoFileBtn" id="photoFileBtn" onclick="uploadPhoto(this)" value="업로드">--%>
                            </div>
                            <form class="forms-sample" name="registerF" id="registerF" accept-charset="utf-8">
                                <div class="row form-group">
                                    <div class="col-6">
                                    <label for="id">아이디</label>
                                    <input readonly type="text" class="form-control" id="id" name="id" value="${loginUser.id}">
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="password">비밀번호</label>
                                        <input readonly type="password" class="form-control" id="password" name="password" value="xxxxx" >
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="name">이름</label>
                                        <input readonly type="text" class="form-control" id="name" name="name" value="${loginUser.name}">
                                    </div>
                                    <div class="col-6">
                                        <label for="gender">성별</label>
                                        <select class="form-control" id="gender" name="gender">
                                            <option>남</option>
                                            <option>여</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <input readonly type="email" class="form-control" id="email" name="email" value="${loginUser.email}">
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="phone">전화번호</label>
                                        <input readonly type="text" class="form-control" id="phone" name="phone" value="${loginUser.phone}">
                                    </div>
                                    <div class="col-6">
                                        <label for="birth">생일</label>
                                        <input readonly type="text" class="form-control" id="birth" name="birth" value="${loginUser.birth}">
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-6">
                                        <label for="address">주소</label>
                                        <input type="text" class="form-control" id="address" name="address" value="${loginUser.address}">
                                    </div>
                                </div>
                                <input type="button" class="btn btn-primary mr-2" value="회원수정" onclick="modify();">
                                <input type="button" class="btn btn-light" value="회원탈퇴" onclick="deleteUser();" >
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:../../partials/_footer.html -->
        <jsp:include page="include/footer.jsp"/>
        <!-- partial -->
    </div>
    <!-- main-panel ends -->
</div>
<!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="../../vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="../../vendors/typeahead.js/typeahead.bundle.min.js"></script>
<script src="../../vendors/select2/select2.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="../../js/off-canvas.js"></script>
<script src="../../js/hoverable-collapse.js"></script>
<script src="../../js/template.js"></script>
<script src="../../js/settings.js"></script>
<script src="../../js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="../../js/file-upload.js"></script>
<script src="../../js/typeahead.js"></script>
<script src="../../js/select2.js"></script>
<!-- End custom js for this page-->

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
    //2. birth -> datepicker 이용
    window.onload = function () {
        $("#birth").datepicker({dateFormat: 'yyyy-MM-dd'});    //시간되면 년도 옮기는 옵션 추가하기
    };

    //3. 파일 업로드시 이미지 보여주기
    // var photoFileBtn = document.getElementById("photoFileBtn");
    // var photofile = document.getElementById("photoFile");
    // photoFileBtn.addEventListener('click',function(){
    //     photofile.click(function(input){
    //         if(input.files && input.files[0]){
    //             var reader = new FileReader();
    //             reader.onload = function(e){
    //                 document.getElementById("prevPhoto").src=e.target.result;
    //             };
    //             reader.readAsDataURL(input.files[0]);
    //         } else {
    //             document.getElementById("prevPhoto").src = 'C:/temp/upload/default.jpg';
    //         }
    //     });
    // });

    //3. 회원가입 버튼 클릭 -> 유효성 검사 -> register-action 실행
    function createUser(){
        var formData = new FormData();
        var id = document.getElementById("id").value;
        var name = document.getElementById("name").value;
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var phone = document.getElementById("phone").value;
        var address = document.getElementById("address").value + document.getElementById("detailedAddress").value;
        var gender = 0;
        //users.gender = document.querySelector('input[name=gender]:checked')[0].value;
        var birth = document.getElementById("birth").value;

        formData.append("id",id);
        formData.append("name",name);
        formData.append("email",email);
        formData.append("password",password);
        formData.append("confirmPassword",confirmPassword);
        formData.append("phone",phone);
        formData.append("address",address);
        formData.append("gender",gender);
        formData.append("birth",birth);

        console.log(photoFile.files[0]);

        /**************************** 유효성 검사 ****************************************/
        if(id === ''){
            document.getElementById("idVal").innerText="아이디를 입력하세요";
            document.getElementById("id").focus();
            return false;
        }
        if(name === ''){
            document.getElementById("nameVal").innerText="이름을 입력하세요";
            document.getElementById("name").focus();
            return false;
        }
        if(password ===''){
            document.getElementById("passwordVal").innerText="비밀번호를 입력하세요";
            document.getElementById("password").focus();
            return false;
        }
        if(confirmPassword ==='') {
            document.getElementById("confirmPasswordVal").innerText="비밀번호 확인을 입력하세요";
            document.getElementById("confirmPassword").focus();
            return false;
        }
        if(email === ''){
            document.getElementById("emailVal").innerText="이메일을 입력하세요";
            document.getElementById("email").focus();
            return false;
        }
        if(phone === ''){
            document.getElementById("phoneVal").innerText="전화번호를 입력하세요";
            document.getElementById("phone").focus();
            return false;
        }
        if(password !== confirmPassword){
            document.getElementById("confirmPasswordVal").innerText="비밀번호와 비밀번호 확인이 일치하지 않습니다.";
            document.getElementById("confirmPassword").focus();
            return false;
        }

        //controller로 데이터 넘기기 --> 파일이 안들어가는듯,,, encoding error? 415에러
        $.ajax({
            type : 'POST',
            url : '/register-action',
            data : formData,
            // dataType: 'json',
            // cache : false,              // ajax 캐시처리
            contentType : false,        // 디폴트: "application/x-www-form=urlencoded; charset=UTF-8"
            processData : false,        // 디폴트 : String -> multipart/form-data가 있으니까 false 처리해줌
            success : function(data){
                alert("회원가입 성공");
            },
            error : function(){
                alert("회원가입 실패");
            }
        });

    }
</script>

</body>
</html>
