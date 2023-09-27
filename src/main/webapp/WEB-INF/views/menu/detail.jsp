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
                                        <div class="form-group col-6">
                                            <label for="parentMenu">상위탭</label>
                                            <c:forEach items="${menuList}" var="menuList">
                                                <c:if test="${menu.parentId == menuList.menuNo}">
                                                    <input type="text" class="form-control" id="parentMenu"
                                                           value="${menuList.menuTitle}" disabled/>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <div class="col-6">
                                            <label for="subMenuList">하위탭</label>
                                            <select class="form-control" id="subMenuList" name="subMenuList">
                                            <c:forEach items="${menuList}" var="menuL">
                                                <c:if test="${menu.menuNo == menuL.parentId && menu.menuNo != menu.parentId}">
                                                <option disabled>${menuL.menuTitle} </option>
                                                </c:if>
                                            </c:forEach>
                                            </select>
                                        </div>
                                    <div class="form-group col-12">
                                        <div style="text-align: right">
                                            <input type="button" id="MenuModifyBtn" name="MenuModifyBtn" class="btn btn-primary mr-2" onclick="location.href='/admin/menu/modify?menuNo=${menu.menuNo}'" value="수정">
                                            <input type="button" id="deleteBtn" name="deleteBtn" class="btn btn-light" onclick="location.href='/admin/menu/delete.action?menuNo=${menu.menuNo}'" value="삭제">
                                        </div>
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