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
                                <h4 class="card-title">메뉴 수정하기</h4>
                                <div class="row">
                                    <div class="form-group col-12">
                                        <label for="menuNo">메뉴번호</label>
                                        <input type="text" class="form-control" id="menuNo" name="menuNo" value="${menu.menuNo}" disabled>
                                    </div>
                                    <div class="form-group col-6">
                                        <label for="menuTitle">메뉴명</label>
                                        <input type="text" class="form-control" id="menuTitle" name="menuTitle"  value="${menu.menuTitle}" />
                                    </div>
                                    <div class="form-group col-6">
                                        <label for="menuDesc">메뉴설명</label>
                                        <input type="text" class="form-control" id="menuDesc" name="menuDesc"  value="${menu.menuDesc}" />
                                    </div>
                                    <div class="form-group col-6">
                                        <label for="menuUrl">URL</label>
                                        <input type="text" class="form-control" id="menuUrl" name="menuUrl"  value="${menu.menuUrl}" />
                                    </div>
                                    <div class="form-group col-6"></div>
                                        <div class="form-group col-6">
                                            <label for="parentId">상위탭</label>
                                            <select class="form-control" id="parentId" name="parentId">
                                            <c:if test="${menu.parentId == 0 }">
                                                <option selected></option>
                                                <option value="0">+ 추가하기</option>
                                            </c:if>
                                            <c:if test="${menu.parentId != 0 }">
                                                <option></option>
                                                <c:forEach items="${subMenuList}" var="subMenu">
                                                <option value="${subMenu.menuNo}" selected>${subMenu.menuTitle}</option>
                                                </c:forEach>
                                                <option value="0">+ 추가하기</option>
                                            </c:if>
                                            </select>
                                        </div>
                                            <div class="col-6">
                                            <label for="subMenu">하위탭</label>
                                            <select class="form-control" id="subMenu" name="subMenu">
                                            <option></option>
                                                <option value="${subMenu.menuNo}">${subMenu.menuTitle}</option>
                                            <option value="0">+ 추가하기</option>
                                            </select>
                                            </div>
                                    <div class="form-group col-12">
                                        <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
                                        <div style="text-align: right">
                                            <input type="button" id="MenuModifyBtn" name="MenuModifyBtn" class="btn btn-primary mr-2" onclick="modifyMenu(${menu.menuNo})" value="수정완료">
                                            <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/menu/detail/${menu.menuNo}'" value="취소">
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
    //1. 메뉴 수정
    function modifyMenu(no){
    let menuNo = no;
    let menuTitle = $('#menuTitle').val();
    let menuDesc = $('#menuDesc').val();
    let menuUrl = $('#menuUrl').val();
    //--> 상위탭 하위탭 선택한 걸로 등록하는 기능
    let parentId = $('#parentId option:selected').val();

    if(menuTitle === ''){
        alert("제목을 입력하세요");
        document.getElementById("boardTitle").focus();
        return false;
    }
    if(menuDesc === ''){
        alert("내용을 입력하세요");
        document.getElementById("boardContent").focus();
        return false;
    }
    if(menuUrl === ''){
        alert("url을 입력하세요");
        document.getElementById("boardContent").focus();
        return false;
    }

    document.getElementById("boardModifyF").method = 'POST';
    document.getElementById("boardModifyF").action = '/board/modify-action/'+no;
    document.getElementById("boardModifyF").submit();
    }


</script>
</html>