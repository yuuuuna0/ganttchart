<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">마이페이지</h4>
                                <!-- 프로필사진 업로드 -->
                                <div class="form-group" style="text-align: center">
                                    <c:if test = "${sessionScope.loginUser.fileNo != 0}">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px"
                                             src="/upload/user/${file.saveName}"/>
                                    </c:if>
                                    <c:if test = "${ sessionScope.loginUser.fileNo == 0}">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/static/images/icons/default.png"/>
                                    </c:if>
                                </div>
                                <form class="forms-sample" name="registerF" id="registerF" accept-charset="utf-8">
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uId">아이디</label>
                                            <input readonly type="text" class="form-control" id="uId" name="uId" value="${sessionScope.loginUser.getUId()}">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-4">
                                            <label for="uPassword">비밀번호</label>
                                            <input readonly type="password" class="form-control" id="uPassword" name="uPassword" value="xxxxx" >
                                        </div>
                                        <div class="col-2 mt-auto">
                                            <input type="button" class="btn btn-primary mr-2" id="passwordBtn" name="passwordBtn" value="비밀번호 변경" onclick="location.href='/user/modifyPassword'" >
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uName">이름</label>
                                            <input readonly type="text" class="form-control" id="uName" name="uName" value="${sessionScope.loginUser.getUName()}">
                                        </div>
                                        <div class="col-6">
                                            <label for="uGender">성별</label>
                                            <select class="form-control" id="uGender" name="uGender" readonly>
                                                <c:if test="${sessionScope.loginUser.getUGender() == '남'}">
                                                    <option selected>남</option>
                                                    <option>여</option>
                                                </c:if>
                                                <c:if test="${sessionScope.loginUser.getUGender() == '여'}">
                                                    <option>남</option>
                                                    <option selected>여</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="uEmail">이메일</label>
                                        <input readonly type="email" class="form-control" id="uEmail" name="uEmail" value="${sessionScope.loginUser.getUEmail()}">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uPhone">전화번호</label>
                                            <input readonly type="text" class="form-control" id="uPhone" name="uPhone" value="${sessionScope.loginUser.getUPhone()}">
                                        </div>
                                        <div class="col-6">
                                            <label >생일</label>
                                            <text readonly class="form-control" id="uBirth" name="uBirth" >
                                            <fmt:formatDate value="${sessionScope.loginUser.getUBirth()}" pattern="yyyy. MM. dd."/>
                                            </text>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="uAddress">주소</label>
                                            <input readonly type="text" class="form-control" id="uAddress" name="uAddress" value="${sessionScope.loginUser.getUAddress()}">
                                        </div><div class="col-6">
                                            <label for="uAddress2">상세주소</label>
                                            <input readonly type="text" class="form-control" id="uAddress2" name="uAddress2" value="${sessionScope.loginUser.getUAddress2()}">
                                        </div>
                                    </div>
                                    <div style="text-align:center;">
                                        <input type="button" class="btn btn-primary mr-2" value="회원수정" onclick="location.href='/user/modify?uId=${sessionScope.loginUser.getUId()}'">
                                        <input type="button" class="btn btn-light" value="회원탈퇴" onclick="location.href='/user/withdrawal.action';" >
                                    </div>
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
    // 생일 양식에 맞게 넣기
    let rawBitrh = $('#birth').val();
    console.log(rawBitrh);
    console.log(typeof $('#birth').val());
    let birth = new Date(rawBitrh).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '.');
    console.log(birth);
    $('#birth').val(birth);
</script>

</body>
</html>