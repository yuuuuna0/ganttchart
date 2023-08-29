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
                        <form class="pt-3" name="loginF">
                            <div class="form-group">
                                <input type="text" class="form-control form-control-lg" id="id" name="id" placeholder="ID">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Password">
                            </div>
                            <div class="mt-3">
                                <input type="button" id="loginBtn" name="loginBtn" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" value="로그인">
                            </div>
                            <div class="my-2 d-flex justify-content-between align-items-center">
                                <div class="form-check">
                                    <label class="form-check-label text-muted">
                                        <input type="checkbox" class="form-check-input">
                                        Keep me signed in
                                    </label>
                                </div>
                                <a href="findId" class="auth-link text-black">Forgot Id?</a>
                                <a href="findPassword" class="auth-link text-black">Forgot password?</a>
                            </div>
                            <div class="mb-2">
                                <button type="button" class="btn btn-block btn-facebook auth-form-btn">
                                    <i class="ti-facebook mr-2"></i>Connect using facebook
                                </button>
                            </div>
                            <div class="text-center mt-4 font-weight-light">
                                Don't have an account? <a href="register" class="text-primary">Create</a>
                            </div>
                        </form>
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
<script src="/static/js/todolist.js"></script>
<!-- endinject -->
<script>
    document.getElementById("loginBtn").onclick=function(){
        document.loginF.method = 'POST';
        document.loginF.action = 'login-action';
        document.loginF.submit();
    }
</script>
</body>

</html>
