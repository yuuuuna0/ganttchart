<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">회원가입</h4>
                                <!-- 프로필사진 업로드 -->
                                <div class="form-group" style="text-align: center">
                                    <c:if test = "${ session.loginUser.photo != null}">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="../upload/users/${sessionScope.loginUser.photo}"/>
                                    </c:if>
                                    <c:if test = "${ session.loginUser.photo == null}">
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "156px" src="../images/icons/default.png"/>
                                    </c:if>
                                </div>
                                <form class="forms-sample" name="registerF" id="registerF" accept-charset="utf-8">
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="id">아이디</label>
                                            <input readonly type="text" class="form-control" id="id" name="id" value="${session.loginUser.getId()}">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="password">비밀번호</label>
                                            <input readonly type="password" class="form-control" id="password" name="password" value="xxxxx" >
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="name">이름</label>
                                            <input readonly type="text" class="form-control" id="name" name="name" value="${session.loginUser.name}">
                                        </div>
                                        <div class="col-6">
                                            <label for="gender">성별</label>
                                            <select class="form-control" id="gender" name="gender">
                                                <c:if test="${session.loginUser.gender == 1}">
                                                    <option selected>남</option>
                                                    <option>여</option>
                                                </c:if>
                                                <c:if test="${session.loginUser.gender == 2}">
                                                    <option>남</option>
                                                    <option selected>여</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">이메일</label>
                                        <input readonly type="email" class="form-control" id="email" name="email" value="${session.loginUser.email}">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="phone">전화번호</label>
                                            <input readonly type="text" class="form-control" id="phone" name="phone" value="${session.loginUser.phone}">
                                        </div>
                                        <div class="col-6">
                                            <label for="birth">생일</label>
                                            <input readonly type="text" class="form-control" id="birth" name="birth" value="${session.loginUser.birth}">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="address">주소</label>
                                            <input readonly type="text" class="form-control" id="address" name="address" value="${session.loginUser.address}">
                                        </div>
                                    </div>
                                    <div style="text-align:center;">
                                        <input type="button" class="btn btn-primary mr-2" value="회원수정" onclick="location.href='/modify'">
                                        <input type="button" class="btn btn-light" value="회원탈퇴" onclick="location.href='/deleteUser';" >
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
</script>

</body>
</html>