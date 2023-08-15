<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-08
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>GanttChart</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body class="bg-nav-fixed">
<!-- header start -->
<div class="header">
    <jsp:include page="include-common-top.jsp"/>
</div>
<!-- header end -->
<div id="layoutSidenav">
    <!-- left side nav start -->
    <div id="navigation">
        <jsp:include page="include-common-left.jsp"/>
    </div>
    <!-- left side nav end -->
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="row justify-content-center">
                    <div class="col-lg-9">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header"><h3 class="text-center font-weight-light my-4">My Page</h3></div>
                            <div class="card-body">
                                <table>
                                    <tr>
                                        <!-- 회원정보 시작 -->
                                        <td>
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input readonly  class="form-control" id="id" name="id" type="text" placeholder="ID" value="${loginUser.id}"/>
                                                        <label for="id">ID</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input readonly class="form-control" id="name" name="name" type="text" placeholder="Name" value="${loginUser.name}"/>
                                                        <label for="name">Name</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-9">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input readonly class="form-control" id="email" name="email" type="email" placeholder="Email" value="${loginUser.email}"/>
                                                        <label for="email">Email</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input readonly class="form-control" id="password" name="password" type="text" placeholder="Password" />
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
                                                <input readonly class="form-control" id="phone" name="phone" type="text" placeholder="Phone number" value="${loginUser.phone}" />
                                                <label for="phone">Phone</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input readonly class="form-control" id="address" name="address" type="text" placeholder="Address" value="${loginUser.address}" />
                                                <label for="address">Address</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input readonly class="form-control" id="detailedAddress" name="detailedAddress" type="text" placeholder="Detailed Address" />
                                                <label for="detailedAddress">Detailed Address</label>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0 btn-group btn-group-toggle" data-toggle="buttons">
                                                        <label class="btn btn-secondary active">
                                                            <input type="radio" name="gender" id="gender1" value="0"> 남
                                                        </label>
                                                        <label class="btn btn-secondary">
                                                            <input type="radio" name="gender" id="gender2" value="1"> 여
                                                        </label>
                                                        <!--
                                                        <input class="form-control" id="gender" name="gender" type="text" placeholder="Gender" />
                                                        toggle로 해서 gender 0:남자 / 1: 여자 숫자 value로 할 예정
                                                        <label for="gender">Gender</label>
                                                        -->
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input readonly class="form-control" id="birth" name="birth" type="text" value="${loginUser.birth}" />
                                                        <label for="birth">$Birth</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid">
                                                    <button class="btn btn-primary btn-block" onclick="location.href='modifyUser?id=${loginUser.id}'">Modify</button>
                                                </div>
                                            </div>
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid">
                                                    <button class="btn btn-primary btn-block" onclick="location.href='deleteUser-action?id=${loginUser.id}'">Withdrawal account</button>
                                                </div>
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

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script>
    //1. 주소 api --> 한글 깨짐 수정해야 함
    window.onload=function() {
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
    window.onload=function() {
        $("#birth" ).datepicker({ dateFormat: 'yyyy-MM-dd' });    //시간되면 년도 옮기는 옵션 추가하기
    };
    /*
        //3. 회원가입 버튼 클릭
        function createUser(){
            var user = {};
            user.id=$("id").val();
            user.password=$("password").val();
            user.passwordConfirm=$("passwordConfirm").val();
            user.email=$("email").val();
            user.name=$("name").val();
            user.phone=$("phone").val();
            user.address=$("address").val();
            user.detailedAddress=$('detailedAddress').val();
            user.gender=$("input[name=gender]:checked").val();
            user.birth=$("birth").val();

            if(user.id == ''){
                alert('아이디를 입력하세요');
                user.id.focus();
            } else if(user.name == ''){
                alert('이름을 입력하세요');
                user.name.focus();
            } else if(user.password ==''){
                alert('비밀번호를 입력하세요');
                user.password.focus();
            } else if(user.passwordConfirm =='') {
                alert('비밀번호 확인을 입력하세요');
                user.passwordConfirm.focus();
            } else if(user.email == ''){
                alert('이메일을 입력하세요');
                user.email.focus();
            } else if(user.phone == ''){
                alert('전화번호를 입력하세요');
                user.phone.focus();
            } else if(user.address == '' || user.detailedAddress == ''){
                alert('주소를 입력하세요');
                user.address.focus();
            } else if(user.password != user.passwordConfirm){
                alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                user.passwordConfirm.focus();
            }
            $.ajax({
                url:'./login-action',
                async:true,
                type:'POST',
                dataType:'json',
                data:Json.stringify(user),
                contentType:'application/json;charset=UTF-8',
                success:function(data) {
                    if (data.status == 0) {window.location.href = './index'}},
                error:function(xhr,status,error){
                    console.error(error);}
            });
        };
     */

    //4. 이메일 인증
    function fn_sendEmail_Ajax() {
        var userEmail = $("#email").val().trim();
        // 메일이 입력 안되면 튕기기
        if (userEmail == "" || userEmail == null) {
            flag_dupl_mail = false;
            alert("이메일 주소를 입력해야 합니다.");
            return;
        }
        var form = {
            email : userEmail
        };
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
                $("#checkCodeDiv").show();},
            error : function() {
                alert("네트워크가 불안정합니다. 다시 시도해 주세요.222");}
        });
    }
</script>
</body>
</html>
