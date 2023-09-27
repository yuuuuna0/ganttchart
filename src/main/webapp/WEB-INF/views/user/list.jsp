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
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-9">
                                        <h4 class="card-title">회원리스트</h4>

                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <div class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchUser(1,'','')"  style="cursor: pointer;">
                                                    <span class="input-group-text" id="search">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </div>
                                                <input type="text" class="form-control" id="keyword" placeholder="검색" value="${keyword}" aria-label="search" aria-describedby="search">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>아이디
                                                <span>
                                                <img src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_id','asc')">
                                                <img src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_id','desc')">
                                                </span>
                                            </th>
                                            <th>회원등급
                                                <span>
                                                 <img src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_type_no','asc')">
                                                <img src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_type_no','desc')">
                                                </span>
                                            </th>
                                            <th>이름
                                                <span>
                                                 <img src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_name','asc')">
                                                <img src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_name','desc')">
                                                </span>
                                            </th>
                                            <th>생일
                                                <span>
                                                 <img src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_birth','asc')">
                                                <img src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_birth','desc')">
                                                </span>
                                            </th>
                                            <th>성별
                                                <span>
                                                <img src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_gender','asc')">
                                                <img src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_gender','desc')">
                                                </span>
                                            </th>
                                            <th>전화번호</th>
                                            <th>이메일</th>
                                            <th>주소</th>
                                            <th>가입일
                                                <span>
                                                 <img src="/static/images/icons/triangleUp.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_create_date','asc')">
                                                <img src="/static/images/icons/triangleDown.png" style="width:10px;height: 5px;" onclick="sortUser(1,'u_create_date','desc')">
                                                </span>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${searchUserList.itemList}" var="user">
                                            <tr style="cursor: pointer;" onclick="goToDetail('${user.getUId()}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${user.getUId()}</td>
                                                <td>
                                                ${user.auth=='ROLE_USER' ? '일반회원' : '주최자'}
                                                </td>
                                                <td>${user.getUName()}</td>
                                                <td><fmt:formatDate value="${user.getUBirth()}" pattern="yyyy. MM. dd."/></td>
                                                <td>${user.getUGender()}</td>
                                                <td>${user.getUPhone()}</td>
                                                <td>${user.getUEmail()}</td>
                                                <td>${user.getUAddress()}  ${user.getUAddress2()}</td>
                                                <td><fmt:formatDate value="${user.getUCreateDate()}" pattern="yyyy. MM. dd."/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
<br>
<br>
                                <div class="row" >
                                    <div class="col-6 ml-3">
                                        <!-- pagination -->
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <!-- preview -->
                                                <c:if test="${searchUserList.pageMaker.blockBegin != 1}">
                                                    <li class="page-item">
                                                        <button  class="page-link" value="${searchUserList.pageMaker.prevBlockBegin}" onclick="searchUser(${searchUserList.pageMaker.prevBlockBegin},'','')" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                                <!-- n개 고정 -->
                                                <c:forEach begin="${searchUserList.pageMaker.blockBegin}" end="${searchUserList.pageMaker.blockEnd}" var="no">
                                                    <c:if test="${no == searchUserList.pageMaker.curPage}">
                                                        <li class="page-item active">
                                                            <button class="page-link" value="${no}" onclick="searchUser(${no},'','')">${no}</button>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${no != searchUserList.pageMaker.curPage}">
                                                        <li class="page-item">
                                                            <button class="page-link" value="${no}" onclick="searchUser(${no},'','')">${no}</button>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${searchUserList.pageMaker.blockEnd!=1 && searchUserList.pageMaker.blockEnd <= searchUserList.pageMaker.totPage}">
                                                    <li class="page-item">
                                                        <button class="page-link" value="${searchUserList.pageMaker.nextBlockBegin}" onclick="searchUser(${searchUserList.pageMaker.nextBlockBegin},'','')" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                            <span class="sr-only">Next</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                    <div class="col-6 ">
                                        <input class="float-right" type="button" value="엑셀 다운로드" onclick="location.href='/admin/user/list/download';">
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
    // 검색창 입력 후 엔터키 => 검색
    $("#searchBtn").keyup(e => {
        if (e.keyCode === 13) {
            searchUser(1,'','');
            e.preventDefault();
        }
    });
    // 회원 검색하기 ---> 검색후 페이지까지 들어가는데 버튼이 안먹는중,,,
    let filterType;
    let ascDesc;
    // 게시글 검색하기
    function searchUser(no,filterType2,ascDesc2){
        let keyword = $('#keyword').val();
        let pageNo = no;
        filterType = "";
        ascDesc ="";
        if(filterType2 !== ""){
            filterType = filterType2;
        }
        if(ascDesc2 !== ""){
            ascDesc = ascDesc2;
        }
        window.location.href='/admin/user/list?pageNo='+pageNo+'&keyword='+keyword+"&filterType="+filterType+"&ascDesc="+ascDesc;
    }

    function goToDetail(id){
        let uId = id;
        window.location.href='/user/detail?uId='+uId;
    }

</script>
