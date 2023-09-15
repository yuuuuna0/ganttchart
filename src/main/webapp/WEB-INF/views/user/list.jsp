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
                                                <div class="input-group-prepend hover-cursor" id="searchBtn" onclick="searchUserList(1)"  style="cursor: pointer;">
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
                                            <th>아이디</th>
                                            <th>회원등급</th>
                                            <th>이름</th>
                                            <th>생일</th>
                                            <th>성별</th>
                                            <th>전화번호</th>
                                            <th>이메일</th>
                                            <th>주소</th>
                                            <th>인증상태</th>
                                            <th>가입일</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${userListPage.itemList}" var="user">
                                            <tr onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${user.id}</td>
                                                <td>${user.grade}</td>
                                                <td>${user.name}</td>
                                                <td><fmt:formatDate value="${user.birth}" pattern="yyyy. MM. dd."/></td>
                                                <td>${user.gender}</td>
                                                <td>${user.phone}</td>
                                                <td>${user.email}</td>
                                                <td>${user.address}</td>
                                                <td>${user.authStatus}</td>
                                                <td><fmt:formatDate value="${user.createDate}" pattern="yyyy. MM. dd."/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
<br>
<br>
                                <div class="row" >
                                    <div class="col-6">
                                        <!-- pagination -->
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">
                                                <!-- preview -->
                                                <c:if test="${userListPage.pageMaker.prevGroupStartPage > 0}">
                                                    <li class="page-item">
                                                        <button  class="page-link" value="${userListPage.pageMaker.prevGroupStartPage}" onclick="searchUserList(${userListPage.pageMaker.prevGroupStartPage})" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                                <!-- n개 고정 -->
                                                <c:forEach begin="${userListPage.pageMaker.blockBegin}" end="${userListPage.pageMaker.blockEnd}" var="no">
                                                    <c:if test="${no == userListPage.pageMaker.curPage}">
                                                        <li class="page-item active">
                                                            <button class="page-link" value="${no}" onclick="searchUserList(${no})">${no}</button>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${no != userListPage.pageMaker.curPage}">
                                                        <li class="page-item">
                                                            <button class="page-link" value="${no}" onclick="searchUserList(${no})">${no}</button>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${userListPage.pageMaker.nextGroupStartPage <= userListPage.pageMaker.totPage}">
                                                    <li class="page-item">
                                                        <button class="page-link" value="${userListPage.pageMaker.nextGroupStartPage}" onclick="searchUserList(${userListPage.pageMaker.nextGroupStartPage})" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                            <span class="sr-only">Next</span>
                                                        </button>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                    <div class="col-6 ">
                                        <input class="float-right" type="button" value="엑셀 다운로드" onclick="location.href='/download';">
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
            searchUserList(1);
            e.preventDefault();
        }
    });
    // 게시글 검색하기 ---> 검색후 페이지까지 들어가는데 버튼이 안먹는중,,,
    function searchUserList(no){
        let keyword = $('#keyword').val();
        let pageNo = no;
        window.location.href='/user/list?pageNo='+pageNo+'&keyword='+keyword;
    }
</script>
