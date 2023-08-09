<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-08
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Register - SB Admin</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- 다음 주소 API 사용 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        //1. 주소 apo --> 한글 깨짐 수정해야 함
        window.onload=function() {
            document.getElementById('createAddress').addEventListener('click', function () {
                new daum.Postcode({
                    oncomplete: function (data) { //선택시 입력값 세팅
                        document.getElementById("createAddress").value = data.address; // 주소 넣기
                        document.querySelector("input[name=detailedAddress]").focus(); //상세입력 포커싱
                    }
                }).open();
            })
        };
        //2. datepicket
        $( function() {
            $( "#datepicker" ).datepicker({ dateFormat: 'yyyy-MM-dd' });    //시간되면 년도 옮기는 옵션 추가하기
        } );
        //3. 회원가입 버튼 클릭
        /*
        function createUser(){
            if(document.getElementById('id').value == ''){
                alert('아이디를 입력하세요');
                newUserInfo.id.focus();
            } else if(document.getElementById('password').value ==''){
                alert('비밀번호를 입력하세요');
                newUserInfo.password.focus();
            } else if(document.getElementById('name') == ''){
                alert('이름을 입력하세요');
                newUserInfo.name.focus();
            } else if(document.getElementById('phone') == ''){
                alert('전화번호를 입력하세요');
                newUserInfo.phone.focus();
            } else if(document.getElementById('address') == ''){
                alert('주소를 입력하세요');
                newUserInfo.address.focus();
            } else if(document.getElementById('password') == document.getElementById('passwordConfirm')){
                alert('비밀번호와 비밀번호 확인은 일치하여야 합니다.');
                newUserInfo.passwordConfirm.focus();
            }
            newUserInfo.action='register-action';
            newUserInfo.method='POST';
            newUserInfo.submit();
            userImage.submit();
        };

         */
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
                            <div class="card-header"><h3 class="text-center font-weight-light my-4">Create Account</h3></div>
                            <div class="card-body">
                                <table>
                                    <tr>
                                        <form id="newUserInfo" accept-charset="utf-8">
                                            <td>
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="id" name="id" type="text" placeholder="ID" />
                                                            <label for="id">ID</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-floating">
                                                            <input class="form-control" id="name" name="name" type="text" placeholder="Name" />
                                                            <label for="name">Name</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- email 입력 및 인증 시작 -->
                                                <div class="row mb-3">
                                                    <div class="col-md-9">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="email" name="email" type="email" placeholder="Email" />
                                                            <label for="password">Email</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-floating mb-2 mb-md-0">
                                                            <button type="button" class="btn btn-outline-primary" id="showDiv" onclick = "fn_sendEmail_Ajax()">
                                                                <i>Verify</i>
                                                            </button>
                                                            <div style="display: none;" id="checkCodeDiv">
                                                                <input type="text" id="inputCode" style="width: 60%; display: inline;" placeholder="인증코드 입력" class="form-control"  />
                                                                <button type="button" class="btn btn-outline-primary" onclick="fn_checkCode()">확인</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- email 입력 및 인증 끝 -->
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="password" name="password" type="text" placeholder="Password" />
                                                            <label for="password">Password</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="passwordConfirm" name="passwordConfirm" type="password" placeholder="Confirm password" />
                                                            <label for="passwordConfirm">Confirm Password</label>
                                                        </div>
                                                    </div>
                                                    <!-- <input value="영문, 숫자, 특수문자를 포함한 8글자 이상 15글자 이하"> -->
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="phone" name="phone" type="text" placeholder="Phone number" />
                                                    <label for="phone">Phone</label>
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="address" name="address" type="text" placeholder="Address" />
                                                    <label for="address">Address</label>
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="detailedAddress" name="detailedAddress" type="text" placeholder="Detailed Address" />
                                                    <label for="detailedAddress">Detailed Address</label>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="gender" name="gender" type="text" placeholder="Gender" />
                                                            <!-- toggle로 해서 gender 0:남자 / 1: 여자 숫자 value로 할 예정 -->
                                                            <label for="gender">Gender</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-floating mb-3 mb-md-0">
                                                            <input class="form-control" id="datepicker" name="birth" type="text" />
                                                            <label for="datepicker">Birth</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mt-4 mb-0">
                                                    <div class="d-grid">
                                                        <button class="btn btn-primary btn-block" type="submit">Create Account</button>
                                                    </div>
                                                </div>
                                            </td>
                                        </form>
                                        <form id="userImage" method="post" enctype="multipart/form-data">
                                            <td>
                                                <!-- 회원가입 시 사진 업로드 부분 -->
                                                <div class="mt-4 mb-0">
                                                    <input type="file" name="uploadfile" multiple>
                                                </div>
                                            </td>
                                        </form>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script>
    //이메일 인증
    function fn_sendEmail_Ajax() {
        var userEmail = $("#email").val().trim();
        // 메일이 입력 안되면 튕기기
        if (userEmail == "" || userEmail == null) {
            flag_dupl_mail = false;
            alert("이메일 주소를 입력해야 합니다.");
            return;
        }
        if(flag_dupl_use_mail == false){
            flag_dupl_mail = false;
            $("#resultMailBox").html("이미 가입된 이메일 입니다").css('color', 'red');
            return;
        }
        var form = {
            email : userEmail
        }

        $.ajax({
            url : "/checkEmailAjax.do",
            data : JSON.stringify(form),
            dataType : "JSON",
            type : "post",
            contentType : "application/json; charset=utf-8;",
            async : false,
            success : function(data) {
                alert("입력하신 이메일 주소에서 발급된 코드를 확인하세요.");
                resultCode = data.joinCode;
                $("#checkCodeDiv").show();
            },
            error : function() {
                alert("네트워크가 불안정합니다. 다시 시도해 주세요.222");
            }
        })
    }
</script>
</body>
</html>
