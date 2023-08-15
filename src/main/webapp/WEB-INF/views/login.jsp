login.jsp

<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-08
  Time: 오전 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>GanttChart</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="js/request.js"></script>
</head>
<body class="bg-primary">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                            <div class="card-body">
                                <form id="loginuser" method="post" action="login-action">
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="id" name="id" type="text" placeholder="ID" />
                                        <label for="id">ID</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="password" name="password" type="password" placeholder="Password" />
                                        <label for="password">Password</label>
                                    </div>
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" id="inputRememberPassword" type="checkbox" value="" />
                                        <label class="form-check-label" for="inputRememberPassword">Remember Password</label>
                                    </div>
                                    <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                        <input style="float:left;" class="small" type="button" value="Forgot Id?" onclick="location.href='/findId'">
                                        <input style="float:left;" class="small" type="button" value="Forgot Password?" onclick="location.href='/findPassword'">
                                        <input class="btn btn-primary" type="submit" value="Login">
                                        <!--
                                        <a class="small" href="password">Forgot Password?</a>
                                        <a class="btn btn-primary" href="index">Login</a>
                                        -->
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small"><a href="register">Need an account? Sign up!</a></div>
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
<script>
    // //로그인 액션
    //   function login(){
    //       if(document.loginuser.id.value == ''){
    //           alert("아이디를 입력하세요")
    //           document.loginuser.id.focus();
    //           return false;
    //       }
    //       if(document.loginuser.password.value == ''){
    //           alert('비밀번호를 입력하세요");
    //           document.loginuser.password.focus();
    //           return false;
    //       }
    //       //ajax 데이터
    //       var url='login-action';
    //       var method='POST';
    //       var contentType='application/json;charset=UTF-8';
    //       var sendData={
    //           id:document.getElementById('id').value,
    //           password:document.getElementById('password').value};
    //       var async=true;
    //       Request.ajaxRequest(url,method,contentType,sendData,
    //                           JSON.stringify(sendData),
    //                           function(resultJson){
    //                           if(resultJson.code==1){window.location.href='index'}
    //                           else{alert(resultJson.msg);}
    //                           }, async);
    //   }


</script>
</body>
</html>
