<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-16
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card" id="boardListPage">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-9">
                                        <h4 class="card-title">메뉴 목록</h4>
                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <btn class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchMenuList(1)" style="cursor: pointer;">
                                                    <span class="input-group-text">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </btn>
                                                <input type="text" class="form-control" id="keyword" name="keyword" placeholder="검색" aria-label="search" aria-describedby="search">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="table-responsive">
                                    <table class="table" >
                                        <thead >
                                        <tr>
                                            <th>No</th>
                                            <th>메뉴</th>
                                            <th>메뉴 설명</th>
                                            <th>Url</th>
                                            <th>상위탭</th>
                                            <th style="text-align: center;">사용등급</th>
                                            <th style="text-align: center;">삭제</th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${searchMenuList.itemList}" var="menu">
                                            <tr style="cursor: pointer;" onclick="goToMenu('${menu.menuNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${menu.menuNo}</td>
                                                <td>${menu.menuTitle}</td>
                                                <td>${menu.menuDesc}</td>
                                                <td>${menu.menuUrl}</td>
                                                <c:choose>
                                                    <c:when test="${menu.menuNo == menu.parentId}">
                                                        <td>-</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${searchMenuList.itemList}" var="menu2">
                                                            <c:if test="${menu.parentId == menu2.menuNo}">
                                                                <td>${menu2.menuTitle}</td>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td style="text-align: center;" onclick="event.cancelBubble=true" >
                                                    <input type="radio" class="btn-check uTypeNo${menu.menuNo}" name="options-outlined${menu.menuNo}" id="success-outlined${menu.menuNo}" autocomplete="off" value="1">
                                                    <label class="btn btn-outline-secondary" for="success-outlined${menu.menuNo}" style="padding: 10px;">일반회원</label>
                                                    <input type="radio" class="btn-check uTypeNo${menu.menuNo}" name="options-outlined${menu.menuNo}" id="danger-outlined${menu.menuNo}" autocomplete="off" value="2">
                                                    <label class="btn btn-outline-secondary ml-1" for="danger-outlined${menu.menuNo}" style="padding: 10px;">주최자</label>
                                                </td>
                                                <td onclick="event.cancelBubble=true" style="text-align: center;"><img src="/static/images/icons/X.png" style="width: 10px; height: 10px;" onclick="deleteMenu(${menu.menuNo})"></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <br>
                                <div class="row" >
                                    <div class="col-6 ml-3">
                                        <!-- pagination -->
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <!-- preview -->
                                                <c:if test="${searchMenuList.pageMaker.blockBegin != 1}">
                                                    <li class="page-item">
                                                        <button  class="page-link" value="${searchMenuList.pageMaker.prevBlockBegin}" onclick="searchUserList(${searchMenuList.pageMaker.prevBlockBegin})" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                                <!-- n개 고정 -->
                                                <c:forEach begin="${searchMenuList.pageMaker.blockBegin}" end="${searchMenuList.pageMaker.blockEnd}" var="no">
                                                    <c:if test="${no == searchMenuList.pageMaker.curPage}">
                                                        <li class="page-item active">
                                                            <button class="page-link" value="${no}" onclick="searchUserList(${no})">${no}</button>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${no != searchMenuList.pageMaker.curPage}">
                                                        <li class="page-item">
                                                            <button class="page-link" value="${no}" onclick="searchUserList(${no})">${no}</button>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${searchMenuList.pageMaker.blockEnd!=1 && searchMenuList.pageMaker.blockEnd <= searchMenuList.pageMaker.totPage}">
                                                    <li class="page-item">
                                                        <button class="page-link" value="${searchMenuList.pageMaker.nextBlockBegin}" onclick="searchUserList(${searchMenuList.pageMaker.nextBlockBegin})" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                            <span class="sr-only">Next</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
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
    function deleteMenu(menuNo){
        // e.stopPropagation();
        window.location.href = '/menu/delete.aciton?menuNo='+menuNo;
    }

    $('.uTypeNo').click(function(e){
        //사용등급 변경하기
        let uTypeNo = e.target.value;
        let menuNo = '${menu.menuNo}';
        console.log(uTypeNo);
        $.ajax({
            url : '/menu/modifyUType.ajax?menuNo='+menuNo,
            method : 'POST',
            data : {
                'menuNo' : menuNo,
                'uTypeNo' : uTypeNo
            },
            success : function (resultMap){
                console.log(resultMap.code);
            },
            error: function (e){
                console.log(e);
            }

        });
    });



    function goToMenu(no){
        window.location.href='/menu/detail?menuNo='+no;
    }
    // 검색창 입력 후 엔터키 => 검색
    $("#searchBtn").keyup(e => {
        if (e.keyCode === 13) {
            searchMenuList(1);
            e.preventDefault();
        }
    });





    // 메뉴 검색하기 ---> 검색후 페이지까지 들어가는데 버튼이 안먹는중,,,
    function searchMenuList(no){
    let keyword = $('#keyword').val();
    let pageNo = no;
    window.location.href='/menu/list?pageNo='+pageNo+'&keyword='+keyword;
    }
    //메뉴 사용여부 확인하기
    $('.usage').change(function(e){
        let useYN;
        let menuNo = e.target.value;
        if (e.target.checked){
            useYN = 0;   //메뉴 사용함
        } else {
            useYN = 1;  //메뉴 사용안함
        }
        $.ajax({
            url : '/menu/usage-ajax',
            method : 'POST',
            data : {
                'menuNo' : menuNo,
                'useYN' : useYN
            },
            success : function(resultMap){
                if(resultMap.code ===1){
                    console.log("성공");
                } else {
                    alert(resultMap.msg);
                }
            },
            error:function(e){
                console.log(e);
            }
        });

    });

</script>

