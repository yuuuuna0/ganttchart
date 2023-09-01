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
                            <h4 class="card-title">비밀번호 찾기</h4>
                            <p class="card-description">
                            </p>
                                <div class="form-group">
                                    <label for="id">아이디</label>
                                    <input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요">
                                </div>
                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
                                </div>
                                <input type="button" onclick="findPasswordAction()" id="findPasswordBtn" class="btn btn-primary mr-2" value="비밀번호찾기">
                                <input type="button" id="cancelBtn" onclick="location.href='/login'" class="btn btn-light" value="취소">
                                <a href="/user/register" class="auth-link text-black float-right" style="font-size: 10pt">Need an account? Sign up!</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
    </div>
    <!-- main-panel ends -->
<script type="text/javascript">
    function findPasswordAction(){
        let id = $('#id').val();
        let name = $('#name').val();
        let email = $('#email').val();
        if (id === '') {
            alert("아이디를 입력하세요");
            $('#id').focus();
            return false;
        }
        if (name === '') {
            alert("이름를 입력하세요");
            $('#name').focus();
            return false;
        }
        if (email === '') {
            alert("이메일을 입력하세요");
            $('#email').focus();
            return false;
        }
            $.ajax({
                url : '/user/findPassword-ajax',
                method : "POST",
                data : {
                    'id': id,
                    'name': name,
                    'email': email
                },
                success : function(resultMap){
                    if(resultMap.code === 1){
                        alert(resultMap.msg);
                        window.location.href=resultMap.forwardPath;
                    } else if(resultMap.code === 2){
                        alert(resultMap.msg);
                    } else if(resultMap.code === 3){
                        alert(resultMap.msg);
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
