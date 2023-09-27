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
                                                <btn class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchGath(1,'','')" style="cursor: pointer;">
                                                    <span class="input-group-text">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </btn>
                                                <input type="text" class="form-control" id="keyword" name="keyword" value="${keyword}" placeholder="검색" aria-label="search" aria-describedby="search">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="table-responsive">
                                    <table class="table" >
                                        <thead >
                                        <tr>
                                            <th>No
                                                <span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_no','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_no','desc')">
                                                </span>
                                            </th>
                                            <th>모임</th>
                                            <th>주최자</th>
                                            <th>모임일
                                                <span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_day','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_day','desc')">
                                                </span>
                                            </th>
                                            <th>모임마감일
                                                <span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_close','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_close','desc')">
                                                </span>
                                            </th>
                                            <th style="text-align: center;">도시<span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchGath(1,'city_no','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchGath(1,'city_no','desc')">
                                                </span>
                                            </th>
                                            <th style="text-align: center;">모임종류<span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_type_no','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_type_no','desc')">
                                                </span>
                                            </th>
                                            <th style="text-align: center;">조회수<span>
                                                <img class="asc" src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_readcount','asc')">
                                                <img class="desc" src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="searchGath(1,'gath_readcount','desc')">
                                                </span>
                                            </th>
                                            <th style="text-align: center;">삭제</th>
                                        </tr>
                                        </thead>
                                        <tbody id="boardTbody">
                                        <c:forEach items="${searchGathList.itemList}" var="gath">
                                            <tr style="cursor: pointer;" onclick="goToMenu('${gath.gathNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${gath.gathNo}</td>
                                                <td>${gath.gathTitle}</td>
                                                <td>${gath.getUId()}</td>
                                                <td>${gath.gathDay}</td>
                                                <td>${gath.gathClose}</td>
                                                <td>도시
                                                <c:choose>
                                                    <c:when test="${}"></c:when>
                                                </c:choose>
                                                </td>
                                                <td>모임종류</td>
                                                <td>${gath.gathReadcount}</td>
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
                                                <c:if test="${searchGathList.pageMaker.blockBegin != 1}">
                                                    <li class="page-item">
                                                        <button  class="page-link" value="${searchGathList.pageMaker.prevBlockBegin}" onclick="searchGath(${searchGathList.pageMaker.prevBlockBegin},'','')" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                                <!-- n개 고정 -->
                                                <c:forEach begin="${searchGathList.pageMaker.blockBegin}" end="${searchGathList.pageMaker.blockEnd}" var="no">
                                                    <c:if test="${no == searchGathList.pageMaker.curPage}">
                                                        <li class="page-item active">
                                                            <button class="page-link" value="${no}" onclick="searchGath(${no},'','')">${no}</button>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${no != searchGathList.pageMaker.curPage}">
                                                        <li class="page-item">
                                                            <button class="page-link" value="${no}" onclick="searchGath(${no},'','')">${no}</button>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${searchGathList.pageMaker.blockEnd!=1 && searchGathList.pageMaker.blockEnd <= searchGathList.pageMaker.totPage}">
                                                    <li class="page-item">
                                                        <button class="page-link" value="${searchGathList.pageMaker.nextBlockBegin}" onclick="searchGath(${searchGathList.pageMaker.nextBlockBegin},'','')" aria-label="Next">
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
        window.location.href = '/admin/menu/delete.aciton?menuNo='+menuNo;
    }

    $('.auth').click(function(e){
        //사용등급 변경하기
        let auth = e.target.value;
        let menuNo = '${menu.menuNo}';
        console.log(auth);
        $.ajax({
            url : '/admin/menu/modifyAuth.ajax?menuNo='+menuNo,
            method : 'POST',
            data : {
                'menuNo' : menuNo,
                'auth' : auth
            },
            success : function (resultMap){
                console.log(resultMap.code);
            },
            error: function (e){
                console.log(e);
            }

        });
    });
    //권한 자기버튼 눌려있기 --> 어떻게?
    $(document).ready(function(){

    });



    function goToMenu(no){
        window.location.href='/admin/menu/detail?menuNo='+no;
    }
    // 검색창 입력 후 엔터키 => 검색
    $("#searchBtn").keyup(e => {
        if (e.keyCode === 13) {
            searchGath(1,'','');
            e.preventDefault();
        }
    });

    let filterType;
    let ascDesc;
    // 게시글 검색하기
    function searchGath(no,filterType2,ascDesc2){
        let keyword = $('#keyword').val();
        let pageNo = no;
        filterType = "";
        ascDesc = "";
        if(filterType2 !== ""){
            filterType = filterType2;
        }
        if(ascDesc2 !== ""){
            ascDesc = ascDesc2;
        }
        console.log(filterType);
        console.log(ascDesc);
        window.location.href='/admin/menu/list?pageNo='+pageNo+'&keyword='+keyword+"&filterType="+filterType+"&ascDesc="+ascDesc;
    }
</script>

