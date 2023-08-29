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
                                                <option disabled></option>
                                                <c:forEach items="${preMenuList}" var="preMenu">
                                                    <c:choose>
                                                        <c:when test="${preMenu.menuNo == menu.parentId}">
                                                            <option value="${preMenu.menuNo}" selected>${preMenu.menuTitle}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${preMenu.menuNo}">${preMenu.menuTitle}</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                                <option value="0">+ 추가하기</option>
                                            </select>
                                        </div>
                                        <div class="col-6">
                                            <label for="subMenu">하위탭</label>
                                            <select class="form-control" id="subMenu" name="subMenu">
                                                <c:forEach items="${subMenuList}" var="subMenu">
                                                    <c:if test="${subMenu.menuNo == subMenu.parentId}">
                                                        <option selected></option>
                                                    </c:if>
                                                    <c:if test="${subMenu.menuNo != subMenu.parentId}">
                                                        <c:choose>
                                                        <c:when test="${subMenu.menuNo == menu.menuNo}">
                                                            <option value="${subMenu.menuNo}" selected>${subMenu.menuTitle}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${subMenu.menuNo}">${subMenu.menuTitle}</option>
                                                        </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </c:forEach>
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
    //상위탭 선택시 하위탭 내용 바뀌기
    $('#parentId').change(function(){
        let parentId = $('#parentId option:selected').val();
        console.log(parentId);
        $.ajax({
            url : '/menu/modify/submenu-ajax',
            method : 'POST',
            data : {
                'parentId' : parentId
            },
            success : function(resultJson){
                console.log(resultJson.subMenuList);
                let subMenuSelect = document.getElementById('subMenu');
                //새로 받은 subMenuList #subMenu에 붙이기
                let subMenuList = resultJson.subMenuList;
                for(let i =0 ; i<subMenuList.length ; i++){
                    let option = document.createElement('option');
                    option.value = subMenuList[i].menuNo;
                    option.text = subMenuList[i].menuTitle;
                    subMenuSelect.appendChild(option);
                }

            }, error :function(e) {
                console.log(e);
            }
        });
    });

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
        document.getElementById("menuTitle").focus();
        return false;
    }
    if(menuDesc === ''){
        alert("메뉴 설명을 입력하세요");
        document.getElementById("menuDesc").focus();
        return false;
    }
    if(menuUrl === ''){
        alert("url을 입력하세요");
        document.getElementById("menuUrl").focus();
        return false;
    }

    document.getElementById("menuModifyF").method = 'POST';
    document.getElementById("menuModifyF").action = '/menu/modify-action/'+no;
    document.getElementById("menuModifyF").submit();
    }


</script>
</html>