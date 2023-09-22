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
                                            <label for="orders">메뉴레벨</label><span style="color: red;">*</span>
                                            <select class="form-control" id="orders" name="orders" disabled>
                                            <c:choose>
                                                <c:when test="${menu.orders == 0}">
                                                    <option value="0" selected>+ 상위탭</option>
                                                    <option value="1" >+ 하위탭</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="0" >+ 상위탭</option>
                                                    <option value="1" selected>+ 하위탭</option>
                                                </c:otherwise>
                                            </c:choose>
                                            </select>
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="parentId">상위탭</label><span style="color: red;">*</span>
                                            <select class="form-control" id="parentId" name="parentId">
                                                <option disabled selected></option>
                                                <c:forEach items="${menuList}" var="menuL">
                                                    <c:if test="${menuL.menuNo == menuL.parentId}">
                                                    <option value="${menuL.menuNo}">${menuL.menuTitle}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuTitle">메뉴명</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="menuTitle" name="menuTitle"  value="${menu.menuTitle}" />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuDesc">메뉴설명</label>
                                            <input type="text" class="form-control" id="menuDesc" name="menuDesc"  value="${menu.menuDesc}" />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuUrl">URL</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="menuUrl" name="menuUrl"  value="${menu.menuUrl}" />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="uTypeNo">사용등급</label>
                                            <select  class="form-control" id="uTypeNo" name="uTypeNo">
                                                <option value="1" disabled selected></option>
                                                <option value="0">관리자</option>
                                                <option value="2">주최자</option>
                                                <option value="1">사용자</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-12">
                                        <div style="text-align: right">
                                            <input type="button" id="MenuModifyBtn" name="MenuModifyBtn" class="btn btn-primary mr-2" onclick="modifyMenu(${menu.menuNo})" value="수정완료">
                                            <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/menu/list?pageNo=1&keyword='" value="목록으로">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
<%--                       CORD BODY END --%>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
    </div>
        <!-- main-panel ends -->
<script>
    window.onload = function(){
        if(${menu.orders == 0}){ //
            let parentIdSelect = $('#parentId');
            parentIdSelect.prop('disabled', true);
        }
        $('#uTypeNo').val(${menu.getUTypeNo()});
    }
    $('#orders').change(function(){
        let ordersSelect = $('#orders');
        let parentIdSelect = $('#parentId');

        if (ordersSelect.val() === "1") { // 하위탭이 선택된 경우
            parentIdSelect.prop('disabled', false); // 상위탭 선택창 활성화
        } else {
            document.getElementById("parentId").selectedIndex = 0;  //selectedIndex는 제이쿼리에서 사용 안됨
            parentIdSelect.prop('disabled', true); // 상위탭 선택창 비활성화
        }
    });

    //1. 메뉴 수정
    function modifyMenu(no){
        let menuNo = no;
        let orders = $('#orders option:selected').val();
        let parentId = no;
        if(orders === "1"){
            parentId = $('#parentId option:selected').val();
        }
        let menuTitle = $('#menuTitle').val();
        let menuDesc = $('#menuDesc').val();
        let menuUrl = $('#menuUrl').val();
        let uTypeNo = $('#uTypeNo option:selected').val();

        if(orders === ''){
            alert("메뉴레벨을 선택하세요");
            return false;
        }
        if(orders === 2 && parentId ===''){
            alert("상위탭을 선택하세요");
            return false;
        }
        if(menuTitle === ''){
            alert("메뉴명을 입력하세요");
            document.getElementById("menuTitle").focus();
            return false;
        }
        if(menuUrl === ''){
            alert("url을 입력하세요");
            document.getElementById("menuUrl").focus();
            return false;
        }

        debugger;
        $.ajax({
            url : '/menu/modify.ajx?menuNo='+menuNo,
            method : 'POST',
            data :{
                'menuNo' : menuNo,
                'menuTitle' : menuTitle,
                'menuDesc' : menuDesc,
                'menuUrl' : menuUrl,
                'orders' : orders,
                'parentId' : parentId,
                'uTypeNo' : uTypeNo
            },
            success: function(resultJson){
                if(resultJson.code === 1){
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