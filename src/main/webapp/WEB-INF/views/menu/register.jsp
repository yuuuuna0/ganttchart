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
                                <h4 class="card-title">메뉴 작성하기</h4>
                                <form name="menuRegisterF" id="menuRegisterF">
                                    <div class="row">
                                        <div class="form-group col-6">
                                            <label for="menuTitle">메뉴명</label>
                                            <input type="text" class="form-control" id="menuTitle" name="menuTitle"  />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuDesc">메뉴설명</label>
                                            <input type="text" class="form-control" id="menuDesc" name="menuDesc"  />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuUrl">URL</label>
                                            <input type="text" class="form-control" id="menuUrl" name="menuUrl"   />
                                        </div>
                                        <div class="form-group col-6"></div>
                                            <div class="form-group col-6">
                                                <label for="parentId">상위탭</label>
                                                <select class="form-control" id="parentId" name="parentId">
                                                    <option></option>
                                                <c:forEach items="${preMenuList}" var="preMenu">
                                                    <option value="${preMenu.menuNo}">${preMenu.menuTitle}</option>
                                                </c:forEach>
                                                    <option value="0">+ 추가하기</option>
                                                </select>
                                            </div>
                                        <div class="form-group col-12">
                                            <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
                                                <div style="text-align: center">
                                                <input type="button" id="menuRegisterBtn" name="menuRegisterBtn" class="btn btn-primary mr-2" onclick="registerMenu()" value="작성">
                                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소">
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </form>
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
    //1. 메뉴 작성
    function registerMenu(){
    let menuTitle = $('#menuTitle').val();
    let menuDesc = $('#menuDesc').val();
    let menuUrl = $('#menuUrl').val();
    //--> 상위탭 하위탭 선택한 걸로 등록하는 기능
    let parentId = $('#parentId option:selected').val();
    console.log(parentId);


    if(menuTitle === ''){
        alert("메뉴명을 입력하세요");
        document.getElementById("boardTitle").focus();
        return false;
    }
    if(menuDesc === ''){
        alert("메뉴설명을 입력하세요");
        document.getElementById("boardContent").focus();
        return false;
    }
    if(menuUrl === ''){
        alert("url을 입력하세요");
        document.getElementById("boardContent").focus();
        return false;
    }

    document.menuRegisterF.method = 'POST';
    document.menuRegisterF.action = '/menu/register-action';
    document.menuRegisterF.submit();
    }


</script>
</html>