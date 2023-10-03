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
                            <form class="forms-sample" id="findIdF">
                                <div class="form-group">
                                    <label for="uName">이름</label>
                                    <input type="text" class="form-control" id="uName" name="uName" placeholder="이름을 입력하세요">
                                </div>
                                <div class="form-group">
                                    <label for="uEmail">이메일</label>
                                    <input type="email" class="form-control" id="uEmail" name="uEmail" placeholder="이메일을 입력하세요">
                                </div>
                                <input id="findIdBtn" type="button" onclick="findId();" class="btn btn-primary mr-2" value="아이디찾기">
                                <input type="button" id="cancelBtn" onclick="location.href='/login'" class="btn btn-light" value="취소">
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
    function findId(){
        let uEmail = $('#uEmail').val();
        let uName = $('#uName').val();

        $.ajax({
            url :'/findId.ajx',
            method: 'POST',
            data : {
                'uEmail' : uEmail,
                'uName' : uName
            },
            success: function (resultJson) {
                if(resultJson.code === 1){
                    $('#findIdF').empty();
                    let html = '';
                    for(let i=0; i<resultJson.data.length; i++){
                        let dataItem = resultJson.data[i];
                        html+="<label>"+dataItem+"</label><br>";
                    }
                    html += "<input id='findIdBtn' type='button' onclick='location.href=\"/findPassword\"' class='btn btn-primary mr-2' value='비밀번호찾기'>\n" +
                        "                                <input type='button' id='cancelBtn' onclick='location.href=\"/login\"' class='btn btn-light' value='로그인'>\n" +
                        "                                <a href='/register' class='auth-link text-black float-right' style='font-size: 10pt'>Need an account? Sign up!</a>";
                    $('#findIdF').append(html);
                } else {
                    alert(resultJson.msg);
                }
            },
            error : function(e){
                alert(e);
            }
        });
    }
</script>

</body>
</html>
