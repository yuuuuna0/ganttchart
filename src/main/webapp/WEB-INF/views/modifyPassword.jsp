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
                                    <label for="uPassword">비밀번호</label>
                                    <input type="password" class="form-control" id="uPassword" name="uPassword" placeholder="비밀번호를 입력하세요">
                                    <label style="font-size: 8pt" for="uPassword">&nbsp;&nbsp;영문,특수문자,숫자를 포함하는 6글자 이상 12글자 이하로 공백을 사용할 수 없습니다.</label>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">비밀번호 확인</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="이메일을 입력하세요">
                                </div>
                                <input id="findIdBtn" type="button" onclick="modifyPassword();" class="btn btn-primary mr-2" value="비밀번호 변경">
                                <input type="button" id="cancelBtn" onclick="location.href='/logout.action'" class="btn btn-light" value="취소">
                                <a href="/register" class="auth-link text-black float-right" style="font-size: 10pt">Need an account? Sign up!</a>
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
        let uPassword = $('#uPassword').val();
        let confirmPassword = $('#confirmPassword').val();

        /**************************** 유효성 검사 ****************************************/
        //1) 비밀번호 정규식 검사
        if (uPassword === '') {
            alert("비밀번호를 입력하세요");
            $('#uPassword').focus();
            return false;
        }
        if (confirmPassword === '') {
            alert("비밀번호확인을 입력하세요");
            $('#confirmPassword').focus();
            return false;
        }
        if (uPassword !== confirmPassword) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $('#uPassword').val('');
            $('#confirmPassword').val('');
            $("#confirmPassword").focus();
            return false;
        }
        $.ajax({
            url : '/modifyPassword.ajx',
            method : 'post',
            data : {
                'uPassword' : uPassword
            },
            success : function(resultMap){
                if(resultMap.code === 1){
                    //1. 성공
                    window.location.href=resultMap.forwardPath;
                } else {
                    alert(resultMap.msg);
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
