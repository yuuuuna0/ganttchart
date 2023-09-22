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
            <div class="content-wrapper align-items-center auth px-5 ">
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <div class="card">
                            <!-- 게시글 -->
                            <div class="card-body">
                                <h4 class="card-title">메뉴 작성하기</h4>
    <hr>
    <br>
    <br>
                                <form class="form-sample" name="menuRegisterF" id="menuRegisterF">
                                    <div class="row">
                                        <div class="form-group col-6">
                                            <label for="orders">메뉴레벨</label><span style="color: red;">*</span>
                                            <select class="form-control" id="orders" name="orders">
                                                <option selected disabled></option>
                                                <option value="0">+ 상위탭</option>
                                                <option value="1">+ 하위탭</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="parentId">상위탭</label><span style="color: red;">*</span>
                                            <select class="form-control" id="parentId" name="parentId" disabled>
                                                <option value="0" selected disabled></option>
                                                <c:forEach items="${menuList}" var="menu">
                                                    <c:if test="${menu.menuNo == menu.parentId}">
                                                    <option value="${menu.menuNo}">${menu.menuTitle}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuTitle">메뉴명</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="menuTitle" name="menuTitle"  />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuDesc">메뉴설명</label>
                                            <input type="text" class="form-control" id="menuDesc" name="menuDesc"  />
                                        </div>
                                        <div class="form-group col-6">
                                            <label for="menuUrl">URL</label><span style="color: red;">*</span>
                                            <input type="text" class="form-control" id="menuUrl" name="menuUrl"   />
                                        </div>
                                        <div class="form-group col-6">
                                                <label for="uTypeNo">사용등급</label>
                                                <select class="form-control" id="uTypeNo" name="uTypeNo">
                                                    <option value="1" disabled selected></option>
                                                    <option value="0">관리자</option>
                                                    <option value="2">주최자</option>
                                                    <option value="1">사용자</option>
                                                </select>
                                        </div>
                                        <div class="form-group col-12">
                                                <div style="text-align: center">
                                                <input type="button" id="menuRegisterBtn" name="menuRegisterBtn" class="btn btn-primary mr-2" onclick="registerMenu()" value="작성">
                                                <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" value="취소">
                                                </div>
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


    //1. 메뉴 작성
    function registerMenu(){
        let orders = $('#orders option:selected').val();
        let parentId;
        if(orders === "1") { //문자열로 비교
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
        $.ajax({
            url : '/menu/register.ajx',
            method : 'POST',
            data :{
                'menuTitle' : menuTitle,
                'menuDesc' : menuDesc,
                'menuUrl' : menuUrl,
                'parentId' : parentId,
                'orders' : orders,
                'uTypeNo' : uTypeNo
            },
            success: function(resultMap){
                if(resultMap.code ===1){
                    window.location.href = resultMap.forwardPath;
                } else {
                    alert(resultMap.msg);
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }


</script>
</html>