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
                <div class="col-md-6 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">아이디 찾기</h4>
                            <p class="card-description">
                            </p>
                            <form class="forms-sample">
                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
                                </div>
                                <input id="findIdBtn" type="submit" class="btn btn-primary mr-2" value="아이디찾기">
                                <input type="button" id="cancelBtn" onclick="location.href='/login'" class="btn btn-light" value="취소">
                                <a href="register" class="auth-link text-black">Need an account? Sign up!</a>
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

</script>

</body>
</html>