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
                                <form name="menuModifyF" id="menuModifyF">
                                <div class="row">
                                    <div class="form-group col-12">
                                        <label for="menuNo">메뉴번호</label>
                                        <input type="text" class="form-control" id="menuNo" name="menuNo" value="${menu.menuNo}" disabled>
                                    </div>
                                    <div class="form-group col-6">
                                    <label for="menuLevel">메뉴레벨</label>
                                    <select class="form-control" id="menuLevel" name="menuLevel" >
                                    <c:choose>
                                        <c:when test="${menu.menuOrder == 0}">
                                            <option value="1" selected>+ 상위탭</option>
                                            <option value="2">+ 하위탭</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1" >+ 상위탭</option>
                                            <option value="2" selected>+ 하위탭</option>
                                        </c:otherwise>
                                    </c:choose>
                                    </select>
                                    </div>
                                    <div class="form-group col-6">
                                    <label for="parentId">상위탭</label>
                                    <c:choose>
                                        <c:when test="${menu.menuOrder == 0}">
                                            <select class="form-control" id="parentId" name="parentId" disabled>
                                        </c:when>
                                        <c:otherwise>
                                            <select class="form-control" id="parentId" name="parentId" >
                                        </c:otherwise>
                                    </c:choose>
                                    <option selected disabled></option>
                                    <c:forEach items="${preMenuList}" var="preMenu">
                                        <option value="${preMenu.menuNo}">${preMenu.menuTitle}</option>
                                    </c:forEach>
                                    </select>
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
                                    <div class="form-group col-6">
                                    <label for="useYN">공개여부</label>
                                    <select class="form-control" id="useYN" name="useYN">
                                    <c:choose>
                                        <c:when test="${menu.useYN == 0}">
                                            <option disabled ></option>
                                            <option value="0" selected>공개</option>
                                            <option value="1">비공개</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option disabled ></option>
                                            <option value="0">공개</option>
                                            <option value="1" selected>비공개</option>
                                        </c:otherwise>
                                    </c:choose>

                                    </select>
                                    </div>
                                    <div class="form-group col-12">
                                        <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.grade == 0}">
                                        <div style="text-align: right">
                                            <input type="button" id="MenuModifyBtn" name="MenuModifyBtn" class="btn btn-primary mr-2" onclick="modifyMenu(${menu.menuNo})" value="수정완료">
                                            <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/menu/list'" value="취소">
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
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
<script>
    $('#menuLevel').change(function(){
    let menuLevelSelect = $('#menuLevel');
    let parentIdSelect = $('#parentId');

    if (menuLevelSelect.val() === "2") { // 하위탭이 선택된 경우
    parentIdSelect.prop('disabled', false); // 상위탭 선택창 활성화
    } else {
    parentIdSelect.prop('disabled', true); // 상위탭 선택창 비활성화
    }
    });

    //1. 메뉴 수정
    function modifyMenu(no){
    let menuNo = no;
    let menuLevel = $('#menuLevel option:selected').val();
    let parentId;
    if(menuLevel === "1"){
        parentId = no;
    }
    if(menuLevel === "2") { //문자열로 비교
    parentId = $('#parentId option:selected').val();
    }
    console.log(parentId);
    let menuTitle = $('#menuTitle').val();
    let menuDesc = $('#menuDesc').val();
    let menuUrl = $('#menuUrl').val();
    let useYN = $('#useYN option:selected').val();

    if(menuTitle === ''){
    alert("메뉴명을 입력하세요");
    document.getElementById("menuTitle").focus();
    return false;
    }
    if(menuDesc === ''){
    alert("메뉴설명을 입력하세요");
    document.getElementById("menuDesc").focus();
    return false;
    }
    if(menuUrl === ''){
    alert("url을 입력하세요");
    document.getElementById("menuUrl").focus();
    return false;
    }
    if(useYN === ''){
    alert("사용레벨을 선택하세요");
    }

    $.ajax({
    url : '/menu/modify-ajax',
    method : 'POST',
    data :{
        'menuNo' : menuNo,
    'menuTitle' : menuTitle,
    'menuDesc' : menuDesc,
    'menuUrl' : menuUrl,
    'useYN' : useYN,
    'parentId' : parentId,
    'menuLevel' : menuLevel
    },
    success: function(resultJson){
    if(resultJson.code ===1){
    window.location.href = '/menu/detail?menuNo='+no;
    } else {
    alert(resultJson.msg);
    }
    },
    error : function(e){
    console.log(e);
    }
    });
    }


</script>
</html>