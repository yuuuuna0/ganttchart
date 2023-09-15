<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:27
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
    <link rel="stylesheet" href="/static/vendors/feather/feather.css">
    <link rel="stylesheet" href="/static/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="/static/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="/static/css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="/static/images/favicon.png" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
<div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth px-0">
            <div class="row w-100 mx-0">
                <div class="col-lg-4 mx-auto">
                    <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                        <div class="brand-logo">
                            <img src="/static/images/logo.svg" alt="logo">
                        </div>
                        <h4>Hello! let's get started</h4>
                        <h6 class="font-weight-light">Sign in to continue.</h6>
                            <div class="form-group">
                                <input type="text" class="form-control form-control-lg" id="uId" name="uId" placeholder="ID">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control-lg" id="uPassword" name="uPassword" placeholder="Password">
                            </div>
                            <div class="mt-3">
                                <input type="button" id="loginBtn" name="loginBtn" onclick="loginAction();" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" value="로그인">
                            </div>
                            <div class="my-2 d-flex justify-content-between align-items-center">
                                <div class="form-check">
                                    <label class="form-check-label text-muted">
                                        <input type="checkbox" class="form-check-input" id= "checkId" name="checkId">
                                        Keep me signed in
                                    </label>
                                </div>
                                <a href="/user/findId" class="auth-link text-black">Forgot Id?</a>
                                <a href="/user/findPassword" class="auth-link text-black">Forgot password?</a>
                            </div>
                            <div class="mb-2">
                                <button type="button" class="btn btn-block btn-facebook auth-form-btn">
                                    <i class="ti-facebook mr-2"></i>Connect using facebook
                                </button>
                            </div>
                            <div class="text-center mt-4 font-weight-light">
                                Don't have an account? <a href="/user/register" class="text-primary">Create</a>
                            </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="/static/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="/static/js/off-canvas.js"></script>
<script src="/static/js/hoverable-collapse.js"></script>
<script src="/static/js/template.js"></script>
<script src="/static/js/settings.js"></script>
<script>
    function loginAction(){
        let uId = $('#uId').val();
        let uPassword = $('#uPassword').val();
        if (uId === '') {
            alert("아이디를 입력하세요");
            $('#uId').focus();
            return false;
        }
        if (uPassword === '') {
            alert("비밀번호를 입력하세요");
            $('#uPassword').focus();
            return false;
        }
        //2. 값이 있을 경우 ajax
        $.ajax({
            url : '/user/login.ajx',
            method : 'post',
            data : {
                'uId' : uId,
                'uPassword' : uPassword
            },
            success : function(resultJson){
                if(resultJson.code === 1){
                    //1. 성공
                    window.location.href=resultJson.forwardPath;
                } else if(resultJson.code === 2){
                    //2. 미인증 사용자
                    window.location.href=resultJson.forwardPath;
                } else if(resultJson.code === 3){
                    //3. 임시비번으로 로그인 한 사람
                    window.location.href=resultJson.forwardPath;
                } else if(resultJson.code === 4) {
                    //4. ID&PW 조합 틀림
                    alert(resultJson.msg);
                    window.location.href = resultJson.forwardPath;
                } else if(resultJson.code === 98){
                    //5. 휴면계정 --> 처리방법 생각하기
                } else {
                    alert(resultJson.msg);
                    window.location.reload();
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }

    // //2. 쿠키로 아이디 기억하기: document.cookie 는 name=value 쌍이며 각 쌍은 ;로 구분된다. =====> cookie1=value1; cookie2=value2;...
    // //1) 저장된 쿠키값을 가져와서 ID칸에 넣어주고 없으면 공백 넣어준다.
    // $(document).ready(function(){
    //     let key = getCookie("key");
    //     let id = $('#id').val(key);
    //     //(이전에 ID 저장상태) 페이지 로딩시 입력칸에 저장된 ID가 표시상태라면
    //     if($('#id').val() !== ""){
    //         $('#checkId').attr("checked",true);
    //     }
    // });
    // //2) 체크박스 변화가 있다면
    // $('#checkId').change(function(){
    //     if($('#checkId').is(':checked')){
    //         //저장 체크할 때
    //         setCookie("key",$('#id').val(),3)       //3일간 쿠키 보관하기
    //     } else{
    //         //체크 해제시 cookie 지워줘야함 -> 쿠키는 특정 키워드에 덮어씌워지는게 아니라 중복으로 서술됨 ex. user=A; user=B; user=C ......
    //         deleteCookie("key");
    //     }
    // });
    // //3) ID 저장하기 체크되어있는 상태에서 ID를 새로 입력하는 경우 --> 이때도 쿠키 저장
    // $('#id').keyup(function(){  //id칸에 id 입력할 때
    //     if($('#checkId').is(':checked')){   //id 체크박스가 체크상태라면
    //         setCookie("key",$('#id').val(),3);  //3일간 쿠키 보관
    //     }
    // });
    //
    // //4) 쿠키 가져오기
    // function getCookie(cookieName){
    //     cookieName = cookieName + '=';
    //     let cookieData = document.cookie;   //브라우저에서 쿠키 접근
    //     let start = cookieData.indexOf(cookieName); // 'key='의 시작 위치 반환
    //     let cookieValue = '';
    //     if(start !== -1){
    //         //쿠키가 존재하면    (cf.-1:쿠키 존재안함)
    //         start += cookieName.length;
    //         let end = cookieData.indexOf(';',start);
    //         if(end === -1) {    //쿠키값의 마지막 위치 인덱스번호 설정
    //             end = cookieData.length;
    //         }
    //         cookieValue = cookieData.substring(start,end);
    //     }
    //     return unescape(cookieValue);   //unescape함수: 특수문자가 포함되어 escape로 변환했던 문자열을 original로 변경해주기 위해 사용하는 함수
    // }
    // //5) 쿠키 저장하기
    // function setCookie(cookieName, value, fordays){
    //     //setCookie ==> daveid 함수에서 넘겨준 시간을 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할을 하는 함수
    //     let exdate = new Date();
    //     exdate.setDate(exdate.getDate() + fordays);
    //     let cookieValue = escape(value) + "; expires =" +exdate.toUTCString();  //id에 특수문자가 포함되어있을 수도 있으므로 escape 함수 사용
    //     document.cookie = cookieName + '=' + cookieValue;
    // }
    // //6) 쿠키 삭제
    // function deleteCookie(cookieName){
    //     let expireDate = new Date();
    //     expireDate.setDate(expireDate.getDate()-1);
    //     document.cookie = cookieName + '=; expires = ' + expireDate.toUTCString();
    // }
    //


</script>
<script src="/static/js/todolist.js"></script>
<!-- endinject -->
</body>

</html>
