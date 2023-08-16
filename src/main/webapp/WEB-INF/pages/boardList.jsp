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
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Skydash Admin</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="../../vendors/feather/feather.css">
    <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="../../images/favicon.png" />
</head>

<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <jsp:include page="include/navbar.jsp"/>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->
        <jsp:include page="include/settings-panel.jsp"/>
        <!-- partial -->
        <!-- partial:partials/_sidebar.html -->
        <jsp:include page="include/sidebar.jsp"/>
        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-9">
                                        <h4 class="card-title">게시글 목록</h4>
                                    </div>
                                    <ul class="col-3 right">
                                        <li class="nav-item nav-search d-none d-lg-block">
                                            <div class="input-group">
                                                <div class="input-group-prepend hover-cursor" id="navbar-search-icon">
                                                    <span class="input-group-text" id="search">
                                                        <i class="icon-search"></i>
                                                    </span>
                                                </div>
                                                <input type="text" class="form-control" id="navbar-search-input" placeholder="Search now" aria-label="search" aria-describedby="search">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Title</th>
                                            <th>Content</th>
                                            <th>Writer</th>
                                            <th>Comment</th>
                                            <th>Date</th>
                                            <th>Read</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${boardListPage.itemList}" var="board">
                                            <tr onclick="goToBoardList('${board.boardNo}')" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                                <td>${board.boardNo}</td>
                                                <td>${board.boardTitle}</td>
                                                <td>${board.boardContent}</td>
                                                <td>${board.id}</td>
                                                <td>${board.boardReadcount}</td>
                                                <td>${board.boardDate}</td>
                                                <td>${board.boardReadcount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>


                                <!-- pagination -->
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                            <c:set var="page" value="${boardListPage.pageMaker.curPage}"/>
                                            <!-- page maxpage를 넘었을 경우 제한 -->
                                            <c:if test="${page > boardListPage.pageMaker.totPage}">
                                                <c:set var="page" value="${boardListPage.pageMaker.totPage}"/>
                                            </c:if>

                                            <!-- 페이지를 5개씩 나누기 위해 현재 페이지에 보여줄 max값 설정 -->
                                            <fmt:formatNumber value="${page/3 - (page/3 % 1)}" type="pattern" pattern="0" var="full"/>
                                            <c:set var="full" value="${full * 3}"/>

                                            <!-- prev(전페이지), next(다음페이지) 개수 설정 -->
                                            <c:set var="scope" value="${page%3}"/>
                                            <c:choose>
                                                <c:when test="${scope == 0}">
                                                    <c:set var="prev" value="3"/>
                                                    <c:set var="next" value="1"/>
                                                </c:when>
                                                <c:when test="${scope < 4}">
                                                    <c:set var="prev" value="${scope}"/>
                                                    <c:set var="next" value="${3-scope}"/>
                                                </c:when>
                                            </c:choose>

                                            <!-- prev 버튼 -->
                                            <c:if test="${page > 3}">
                                                <fmt:formatNumber value="${(page-1)/3 - (((page-1)/3) % 1)}" type="pattern" pattern="0" var="prevb"/>
                                                <c:set value="${(prevb-1)*3 + 1}" var="prevb"/>
<%--                                                <span id="prevBtn" class="prev button" value="${prevb}"></span>--%>
                                                <li class="page-item">
                                                    <a class="page-link" href="#" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Previous</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <!-- 전 페이지 -->
                                            <c:if test="${page != 1}">
                                                <c:set var="j" value="${prev}"/>
                                                <c:forEach var="i" begin="1" end="${prev-1}">
                                                    <c:set var="j" value="${j - 1}"/>
                                                    <c:if test="${(page - j) > 0}">
<%--                                                        <span class="no">${page - j}</span>--%>
                                                        <li class="page-item"><a class="page-link" href="#">${page-j}</a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <!-- 현재 페이지 -->
<%--                                            <span class="no selected">${page}</span>--%>
                                                <li class="page-item"><a class="page-link" href="#">${page}</a></li>

                                            <!-- 다음 페이지 -->
                                            <c:if test="${page != boardListPage.pageMaker.totPage}">
                                                <c:forEach var="i" begin="1" end="${next-1}">
                                                    <c:if test="${boardListPage.pageMaker.totPage >= page+i}">
<%--                                                        <span class="no">${page+i}</span>--%>
                                                        <li class="page-item"><a class="page-link" href="#">${page+i}</a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <!-- next 버튼 -->
                                            <c:if test="${boardListPage.pageMaker.totPage >= page + next}">
                                                <fmt:formatNumber value="${(page-1)/3 - (((page-1)/3) % 1)}" type="pattern" pattern="0" var="nextb"/>
                                                <c:set value="${(nextb+1)*3 + 1}" var="nextb"/>
            <%--                                                <span id="prevBtn" class="prev button" value="${nextb}"></span>--%>
                                                <a class="page-link" id="nextBtn" href="#" value="${nextb}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </c:if>
                                    </ul>
                                </nav>
                                <!-- pagination 끝 -->



                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
            <!-- partial:../../partials/_footer.html -->
            <jsp:include page="include/footer.jsp"/>
            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="../../vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="../../js/off-canvas.js"></script>
<script src="../../js/hoverable-collapse.js"></script>
<script src="../../js/template.js"></script>
<script src="../../js/settings.js"></script>
<script src="../../js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<!-- End custom js for this page-->
</body>
<script>
    function goToBoardList(boardNo){
        window.location.href='/boardDetail/'+boardNo;
    }
</script>

</html>
