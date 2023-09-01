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
                                    <c:if test = "${ sessionScope.loginUser.saveFileName != null}">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px"
                                             src="${sessionScope.loginUser.filePath}${sessionScope.loginUser.saveFileName}"/>
                                    </c:if>
                                    <c:if test = "${ sessionScope.loginUser.saveFileName == null}">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "156px" src="/static/images/icons/default.png"/>
                                    </c:if>
                                </div>
                                <form class="forms-sample" name="registerF" id="registerF" accept-charset="utf-8">
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="id">아이디</label>
                                            <input readonly type="text" class="form-control" id="id" name="id" value="${sessionScope.loginUser.id}">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-4">
                                            <label for="password">비밀번호</label>
                                            <input readonly type="password" class="form-control" id="password" name="password" value="xxxxx" >
                                        </div>
                                        <div class="col-2 mt-auto">
                                            <input type="button" class="btn btn-primary mr-2" id="passwordBtn" name="passwordBtn" value="비밀번호 변경" onclick="location.href='/user/modifyPassword'" >
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="name">이름</label>
                                            <input readonly type="text" class="form-control" id="name" name="name" value="${sessionScope.loginUser.name}">
                                        </div>
                                        <div class="col-6">
                                            <label for="gender">성별</label>
                                            <select class="form-control" id="gender" name="gender" readonly>
                                                <c:if test="${sessionScope.loginUser.gender == '남'}">
                                                    <option selected>남</option>
                                                    <option>여</option>
                                                </c:if>
                                                <c:if test="${sessionScope.loginUser.gender == '여'}">
                                                    <option>남</option>
                                                    <option selected>여</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">이메일</label>
                                        <input readonly type="email" class="form-control" id="email" name="email" value="${sessionScope.loginUser.email}">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="phone">전화번호</label>
                                            <input readonly type="text" class="form-control" id="phone" name="phone" value="${sessionScope.loginUser.phone}">
                                        </div>
                                        <div class="col-6">
                                            <label >생일</label>
                                            <text readonly class="form-control" id="birth" name="birth" >
                                            <fmt:formatDate value="${sessionScope.loginUser.birth}" pattern="yyyy. MM. dd."/>
                                            </text>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="address">주소</label>
                                            <input readonly type="text" class="form-control" id="address" name="address" value="${sessionScope.loginUser.address}">
                                        </div>
                                    </div>
                                    <div style="text-align:center;">
                                        <input type="button" class="btn btn-primary mr-2" value="회원수정" onclick="location.href='/user/modify'">
                                        <input type="button" class="btn btn-light" value="회원탈퇴" onclick="location.href='/user/delete-action';" >
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