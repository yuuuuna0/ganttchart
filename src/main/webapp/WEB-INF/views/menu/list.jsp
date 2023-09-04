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
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>메뉴</th>
                                            <th>Url</th>
                                            <th>메뉴 설명</th>
                                            <th>상위탭</th>
                                            <th>사용여부</th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${menuListPage.itemList}" var="menu">
                                            <tr style="cursor: pointer;" onclick="goToMenu('${menu.menuNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${menu.menuNo}</td>
                                                <td>${menu.menuTitle}</td>
                                                <td>${menu.menuUrl}</td>
                                                <td>${menu.menuDesc}</td>
                                                <c:choose>
                                                    <c:when test="${menu.menuNo == menu.parentId}">
                                                        <td>-</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${preMenuList}" var = "preMenu">
                                                            <c:if test="${menu.parentId == preMenu.menuNo}">
                                                                <td>${preMenu.menuTitle}</td>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            <td onclick="event.cancelBubble=true">
                                            <c:if test="${menu.useYN == 1}">
                                            <input class="usage" type="checkbox" value="${menu.menuNo}" />
                                            </c:if>
                                            <c:if test="${menu.useYN == 0}">
                                            <input class="usage" type="checkbox" value="${menu.menuNo}" checked/>
                                             </c:if>
                                            </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <br>
                                <!-- pagination -->
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">
                                            <!-- preview -->
                                            <c:if test="${menuListPage.pageMaker.prevGroupStartPage > 0}">
                                                <li class="page-item">
                                                <button  class="page-link" value="${menuListPage.pageMaker.prevGroupStartPage}" onclick="searchMenuList(${menuListPage.pageMaker.prevGroupStartPage})" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </button>
                                                </li>
                                            </c:if>
                                            <!-- n개 고정 -->
                                                <c:forEach begin="${menuListPage.pageMaker.blockBegin}" end="${menuListPage.pageMaker.blockEnd}" var="no">
                                                            <c:if test="${no == menuListPage.pageMaker.curPage}">
                                                                <li class="page-item active">
                                                                <button class="page-link" value="${no}" onclick="searchMenuList(${no})">${no}</button>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${no != menuListPage.pageMaker.curPage}">
                                                                <li class="page-item">
                                                                <button class="page-link" value="${no}" onclick="searchMenuList(${no})">${no}</button>
                                                                </li>
                                                            </c:if>
                                                </c:forEach>
                                            <c:if test="${menuListPage.pageMaker.nextGroupStartPage <= menuListPage.pageMaker.totPage}">
                                                <li class="page-item">
                                                    <button class="page-link" value="${menuListPage.pageMaker.nextGroupStartPage}" onclick="searchMenuList(${menuListPage.pageMaker.nextGroupStartPage})" aria-label="Next">
                                                        <span aria-hidden="true">&laquo;</span>
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
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
<script>
    function deleteMenu(e,no){
        e.stopPropagation();
        window.location.href = '/menu/delete-action?menuNo='+no;
    }

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

