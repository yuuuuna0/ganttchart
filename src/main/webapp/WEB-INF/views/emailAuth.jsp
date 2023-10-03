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
                            <h4 class="card-title">이메일 인증</h4>
                            <p class="card-description">
                            </p>
                            <div class="small mb-3 text-muted">Enter your secret code to verify your ID!!</div>
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="uAuthCode" name="uAuthCode" type="text"/>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <a class="small" href="/login">Return to login</a>
                                    <button class="btn btn-primary" onclick="emailAuthAction()">Verify</button>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
    </div>
    <!-- main-panel ends -->
<script type="text/javascript">

    function emailAuthAction(){
        let uAuthCode = $('#uAuthCode').val();
        if(uAuthCode ===""){
            alert("인증번호를 입력하세요");
            $('#uAuthCode').focus();
            return false;
        }
        $.ajax({
            url : '/emailAuth.ajx',
            method : 'POST',
            data : {
                'uAuthCode' : uAuthCode
            },
            success : function (resultMap) {
                if(resultMap.code === 1){
                    window.location.href = resultMap.forwardPath;
                } else{
                    alert(msg);
                    window.location.reload();
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
</script>

</body>
</html>
