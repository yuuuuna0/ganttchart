<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>GanttChart</title>
    <link href="css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>    <script src="js/scripts.js"></script>
    <!-- 다음 주소 API 사용 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
</script>
</head>
<body class="bg-primary">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-9">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header"><h3 class="text-center font-weight-light my-4">Create Account</h3>
                            </div>
                            <div class="card-body">
                                <table>
                                    <tr>
                                         <!-- 회원가입 정보 입력 시작 -->
                                        <td>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <form name="registerForm" method="POST" id="registerForm" accept-charset="utf-8" >
                                                        <div class="row mb-3">
                                                            <div class="col-md-6">
                                                                <div class="form-floating mb-3 mb-md-0">
                                                                    <input class="form-control" id="id" name="id" type="text" placeholder="ID"/>
                                                                    <label for="id">ID</label>
                                                                    <label id="idVal"></label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-floating">
                                                                    <input class="form-control" id="name" name="name" type="text" placeholder="Name"/>
                                                                    <label for="name">Name</label>
                                                                    <label id="nameVal"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-md-12">
                                                                <div class="form-floating mb-3 mb-md-0">
                                                                    <input class="form-control" id="email" name="email" type="email" placeholder="Email"/>
                                                                    <label for="email">Email</label>
                                                                    <label id="emailVal"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-md-6">
                                                                <div class="form-floating mb-3 mb-md-0">
                                                                    <input class="form-control" id="password" name="password" type="password" placeholder="Password"/>
                                                                    <label for="password">Password</label>
                                                                    <label id="passwordVal"></label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-floating mb-3 mb-md-0">
                                                                    <input class="form-control" id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm password"/>
                                                                    <label for="confirmPassword">Confirm Password</label>
                                                                    <label id="confirmPasswordVal"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-floating mb-3">
                                                            <input class="form-control" id="phone" name="phone" type="text" placeholder="Phone number"/>
                                                            <label for="phone">Phone</label>
                                                            <label id="phoneVal"></label>
                                                        </div>
                                                        <div class="form-floating mb-3">
                                                            <input class="form-control" id="address" name="address" type="text" placeholder="Address"/>
                                                            <label for="address">Address</label>
                                                            <label id="addressVal"></label>
                                                        </div>
                                                        <div class="form-floating mb-3">
                                                            <input class="form-control" id="detailedAddress" name="detailedAddress" type="text" placeholder="Detailed Address"/>
                                                            <label for="detailedAddress">Detailed Address</label>
                                                            <label id="detailedAddressVal"></label>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-md-6">
                                                                <div class="form-floating mb-3 mb-md-0 btn-group btn-group-toggle" data-toggle="buttons">
                                                                    <label class="btn btn-secondary active" >
                                                                        <input type="radio" name="gender" id="gender1" checked value="0">
                                                                        남
                                                                    </label>
                                                                    <label class="btn btn-secondary active">
                                                                        <input type="radio" name="gender" id="gender2" value="1">
                                                                        여
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-floating mb-3 mb-md-0">
                                                                    <input class="form-control" id="birth" name="birth" type="text"/>
                                                                    <label for="birth">Birth</label>
                                                                </div>
                                                            </div>
                                                            <label id="genderVal"></label>
                                                        </div>
                                                    </form>
                                                </div>
                                                <!-- 회원가입 시 사진 업로드 부분 -->
                                                <div class="col-md-6">
                                                    <div class="imageDiv">
                                                        <img style="width:500px;" id="prevPhoto" />
                                                        <input style="display: block" type="file" id="photoFile" name="photoFile" onchange="uploadImg(this);">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 회원가입 정보 입력 끝 -->
                                            <div class="d-grid">
                                                <input type="button" class="btn btn-primary btn-block" id="register" onclick="createUser()" value="Create Account">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small"><a href="login">Have an account? Go to login</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <div id="layoutAuthentication_footer">
        <footer class="py-4 bg-light mt-auto">
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between small">
                    <div class="text-muted">Copyright &copy; Your Website 2023</div>
                    <div>
                        <a href="#">Privacy Policy</a>
                        &middot;
                        <a href="#">Terms &amp; Conditions</a>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</div>
<script>
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

    //파일 선택시 이미지 보여주기
    function uploadImg(input){
        if(input.files && input.files[0]){
            var reader = new FileReader();
            reader.onload=function(e){
                document.getElementById('prevPhoto').src=e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else{
            document.getElementById('prevPhoto').src='C:/temp/upload/default.jpg';
        }
    }

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
        var photoFile = document.getElementById("photoFile");

        formData.append("id",id);
        formData.append("name",name);
        formData.append("email",email);
        formData.append("password",password);
        formData.append("confirmPassword",confirmPassword);
        formData.append("phone",phone);
        formData.append("address",address);
        formData.append("gender",gender);
        formData.append("birth",birth);
        formData.append("photoFile",document.getElementById('photoFile').files[0]);

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



    // //4. 이메일 인증
    //     function fn_sendEmail_Ajax() {
    //         var userEmail = $("#email").val().trim();
    //         // 메일이 입력 안되면 튕기기
    //         if (userEmail == "" || userEmail == null) {
    //             flag_dupl_mail = false;
    //             alert("이메일 주소를 입력해야 합니다.");
    //             return;
    //         }
    //         var form = {
    //             email : userEmail
    //         };
    //         $.ajax({
    //             url : "/checkEmailAjax.do",
    //             data : JSON.stringify(form),
    //             dataType : "JSON",
    //             type : "post",
    //             contentType : "application/json; charset=utf-8;",
    //             async : false,
    //             success : function(data) {
    //                 alert("입력하신 이메일 주소에서 발급된 코드를 확인하세요.");
    //                 resultCode = data.joinCode;
    //                 $("#checkCodeDiv").show();},
    //             error : function() {
    //                 alert("네트워크가 불안정합니다. 다시 시도해 주세요.222");}
    //         });
    //     }
</script>
</body>
</html>
