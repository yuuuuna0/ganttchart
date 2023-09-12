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
                                <!-- 프로필사진 업로드 : controller에서 존재여부 파악하여 붙여주기 -->
                                <div class="form-group" style="text-align: center">
<%--                                    <c:if test = "${ loginMember.saveFileName != null}">--%>
<%--                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "200px"--%>
<%--                                             src="/upload/member/${loginMember.saveFileName}"/>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test = "${ loginMember.saveFileName == null}">--%>
                                        <img id="prevPhoto" class="img-fluid styled profile_pic rounded-circle"  width = "156px" src="/static/images/icons/default.png"/>
<%--                                    </c:if>--%>
                                </div>
                                <form class="forms-sample" name="registerF" id="registerF" accept-charset="utf-8">
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="id">아이디</label>
                                            <input readonly type="text" class="form-control" id="id" name="id" value="${loginMember.getMId()}">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-4">
                                            <label for="password">비밀번호</label>
                                            <input readonly type="password" class="form-control" id="password" name="password" value="xxxxx" >
                                        </div>
                                        <div class="col-2 mt-auto">
                                            <input type="button" class="btn btn-primary mr-2" id="passwordBtn" name="passwordBtn" value="비밀번호 변경" onclick="location.href='/member/modifyPassword'" >
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="name">이름</label>
                                            <input readonly type="text" class="form-control" id="name" name="name" value="${loginMember.getMName()}">
                                        </div>
                                        <div class="col-6">
                                            <label for="gender">성별</label>
                                            <select class="form-control" id="gender" name="gender" readonly>
                                                <c:if test="${loginMember.getMGender() == '남'}">
                                                    <option selected>남</option>
                                                    <option>여</option>
                                                </c:if>
                                                <c:if test="${loginMember.getMGender() == '여'}">
                                                    <option>남</option>
                                                    <option selected>여</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">이메일</label>
                                        <input readonly type="email" class="form-control" id="email" name="email" value="${loginMember.getMEmail()}">
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="phone">전화번호</label>
                                            <input readonly type="text" class="form-control" id="phone" name="phone" value="${loginMember.getMPhone()}">
                                        </div>
                                        <div class="col-6">
                                            <label >생일</label>
                                            <text readonly class="form-control" id="birth" name="birth" >
                                            <fmt:formatDate value="${loginMember.getMBirth()}" pattern="yyyy. MM. dd."/>
                                            </text>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-6">
                                            <label for="address">주소</label>
                                            <input readonly type="text" class="form-control" id="address" name="address" value="${loginMember.getMAddr()}">
                                        </div><div class="col-6">
                                            <label for="mAddr2">상세주소</label>
                                            <input readonly type="text" class="form-control" id="mAddr2" name="mAddr2" value="${loginMember.getMAddr2()}">
                                        </div>
                                    </div>
                                    <div style="text-align:center;">
                                        <input type="button" class="btn btn-primary mr-2" value="회원수정" onclick="location.href='/member/modify'">
                                        <input type="button" class="btn btn-light" value="회원탈퇴" onclick="location.href='/member/delete-action';" >
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