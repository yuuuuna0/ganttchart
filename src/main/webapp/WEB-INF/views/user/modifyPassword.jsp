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
                            <h4 class="card-title">비밀번호 변경</h4>
                            <p class="card-description">
                            </p>
                            <form class="forms-sample" id="modifyPasswordF" name="modifyPasswordF">
                                <div class="form-group">
                                    <label for="password">비밀번호</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요">
                                    <label style="font-size: 8pt" for="password">&nbsp;&nbsp;영문,특수문자,숫자를 포함하는 6글자 이상 12글자 이하로 공백을 사용할 수 없습니다.</label>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">비밀번호 확인</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="이메일을 입력하세요">
                                </div>
                                <input id="findIdBtn" type="button" onclick="modifyPassword();" class="btn btn-primary mr-2" value="비밀번호 변경">
                                <input type="button" id="cancelBtn" onclick="location.href='/login'" class="btn btn-light" value="취소">
                                <a href="/user/register" class="auth-link text-black float-right" style="font-size: 10pt">Need an account? Sign up!</a>
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
    function modifyPassword(){
        let password = $('#password').val();
        let confirmPassword = $('#confirmPassword').val();

        /**************************** 유효성 검사 ****************************************/
        //1) 비밀번호 정규식 검사
        if (password === '') {
            alert("비밀번호를 입력하세요");
            document.getElementById("password").focus();
            return false;
        }
        if (password === '') {
            alert("비밀번호확인을 입력하세요");
            document.getElementById("password").focus();
            return false;
        }
        $.ajax({
            url : '/user/modifyPassword-ajax',
            method : 'post',
            data : {
                'password' : password,
                'confirmPassword' : confirmPassword
            },
            success : function(resultMap){
                if(resultMap.code === 1){
                    //1. 성공
                    window.location.href=resultMap.forwardPath;
                } else if(resultMap.code === 2){
                    alert(resultMap.msg);
                    window.location.href=resultMap.forwardPath;
                } else if(resultMap.code === 3){
                    window.location.href=resultMap.forwardPath;
                } else {
                    alert(resultMap.msg);
                    window.location.href=resultMap.forwardPath;
                }
            },
            error : function(e){
                console.log(e);
            }
        });

    }
</script>

</body>
</html>
