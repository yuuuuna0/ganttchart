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
                            <!-- 게시글 -->
                            <div class="card-body">
                                <h4 class="card-title">메뉴 상세보기</h4>
                                <div class="row">
                                    <div class="form-group col-12">
                                        <label for="menuNo">메뉴번호</label>
                                        <input type="text" class="form-control" id="menuNo" name="menuNo" value="${menu.menuNo}" disabled>
                                    </div>
                                    <div class="form-group col-6">
                                        <label for="menuTitle">메뉴명</label>
                                        <input type="text" class="form-control" id="menuTitle" name="menuTitle"  value="${menu.menuTitle}" disabled/>
                                    </div>
                                    <div class="form-group col-6">
                                        <label for="menuDesc">메뉴설명</label>
                                        <input type="text" class="form-control" id="menuDesc" name="menuDesc"  value="${menu.menuDesc}" disabled/>
                                    </div>
                                    <div class="form-group col-6">
                                        <label for="menuUrl">URL</label>
                                        <input type="text" class="form-control" id="menuUrl" name="menuUrl"  value="${menu.menuUrl}" disabled/>
                                    </div>
                                    <div class="form-group col-6"></div>
                                    <c:choose>
                                        <c:when test="${menu.parentId == 0}">
                                        <div class="form-group col-6">
                                            <label for="parentMenu1">상위탭</label>
                                                    <input type="text" class="form-control" id="parentMenu1" value="-" disabled/>
                                        </div>
                                        <div class="col-6">
                                            <label for="subMenuList">하위탭</label>
                                            <select class="form-control" id="subMenuList" name="subMenuList">
                                                <c:forEach items="${subMenuList}" var="subMenu">
                                                    <option value="${subMenu.menuNo}" disabled>${subMenu.menuTitle}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        </c:when>
                                        <c:otherwise>
                                        <div class="form-group col-6">
                                            <label for="parentMenu2">상위탭</label>
                                            <input type="text" class="form-control" id="parentMenu2"  value="${preMenu.menuTitle}" disabled/>
                                        </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="form-group col-12">
                                        <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
                                        <div style="text-align: right">
                                            <input type="button" id="MenuModifyBtn" name="MenuModifyBtn" class="btn btn-primary mr-2" onclick="location.href='/menu/modify/${menu.menuNo}'" value="수정">
                                            <input type="button" id="deleteBtn" name="deleteBtn" class="btn btn-light" onclick="location.href='/menu/delete-action/${menu.menuNo}'" value="삭제">
                                        </div>
                                        </c:if>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
<script>



</script>
</html>