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
                    <input type="hidden" value="${gath.gathNo}" id="gathNo">
                    <div class="card-body">
                        <h4 class="card-title">게시글 상세보기</h4>
                        <div class="form-group row">
                            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-indicators">
                                    <c:forEach items="${fileList}" varStatus="no">
                                        <c:choose>
                                        <c:when test="${no.index == 0}">
                                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${no.index}" class="active" aria-current="true" aria-label="Slide ${no.index}"></button>
                                        </c:when>
                                        <c:otherwise>
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${no.index}" aria-label="Slide ${no.index}"></button>
                                        </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <div class="carousel-inner">
                                    <c:forEach items="${fileList}" var="file">
                                    <div class="carousel-item active">
                                        <img src="/upload/gathering/${file.saveName}" style="width: 50%; height: 500px;  object-fit: cover;" class="d-block w-100" alt="...">
                                    </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-6">
                            <label for="gathTitle">제목</label>
                            <input type="text"  class="form-control" id="gathTitle" name="gathTitle"
                                   value="${gath.gathTitle}" disabled>
                            </div>
                            <div class="col-6">
                                <label for="readCount">조회수</label>
                                <input  type="text" class="form-control" id="readCount" name="readCount"
                                       value="${gath.gathReadcount}" disabled>
                            </div>
                        </div>
                        <div class="form-group row" >
                            <div class="col-6">
                            <label for="name">작성자</label>
                            <input  type="text" class="form-control" id="name" name="name"
                                   value="${gath.getUId()}" disabled>
                            </div>
                            <div class="col-6">
                            <label for="date">작성일</label>
                            <input  type="text" class="form-control" id="date" name="date"
                                   value="<fmt:formatDate value="${gath.gathCreateDate}" pattern="yyyy. MM. dd."/>" disabled>
                            </div>
                        </div><div class="form-group row" >
                            <div class="col-6">
                            <label for="city">지역</label>
                            <input  type="text" class="form-control" id="city" name="city"
                                   value="${gath.city.city}" disabled>
                            </div>
                            <div class="col-6">
                            <label for="gathType">카테고리</label>
                            <input  type="text" class="form-control" id="gathType" name="gathType"
                                   value="${gath.gatheringType.gathType}" disabled>
                            </div>
                        </div><div class="form-group row" >
                            <div class="col-4">
                            <label for="gathDay">모임일</label>
                            <input  type="text" class="form-control" id="gathDay" name="gathDay"
                                     value='<fmt:formatDate value="${gath.gathDay}" pattern="yyyy. MM. dd."/>'  disabled>
                            </div>
                            <div class="col-4">
                            <label for="gathClose">모집마감일</label>
                            <input  type="text" class="form-control" id="gathClose" name="gathClose"
                                    value='<fmt:formatDate value="${gath.gathClose}" pattern="yyyy. MM. dd."/>' disabled>
                            </div><div class="col-4">
                            <label for="gathAmount">잔여인원</label>
                            <input  type="text" class="form-control" id="gathAmount" name="gathAmount"
                                   value="${gath.gathAmount}" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="gathDesc">내용</label>
                            <textarea class="form-control" id="gathDesc" name="gathDesc" rows="4"
                                      disabled>${gath.gathDesc}</textarea>
                        </div>

                            <div class=" flex" style="display: flex; justify-content: flex-end;">
                                    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.getUId() == gath.getUId()}">
                                        <input type="button" id="gathCreateBtn" name="gathCreateBtn"
                                               class="btn btn-primary mr-2"
                                               onclick="location.href='/gathering/modify?gathNo=${gath.gathNo}'" value="수정">
                                        <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light"
                                               onclick="location.href='/gathering/delete.action?gathNo=${gath.gathNo}'" value="삭제">
                                    </c:if><input type="button" id="listBtn" name="listBtn" class="btn btn-primary ml-2"
                                           onclick="location.href='/gathering/list?pageNo=1&keyword='" value="목록으로">
                            </div>
                        </div>
                    </div>
                    <hr>
<%--                    <!-- 댓글 시작 -->--%>
<%--                    <div class="card-body" style="padding-top: 0;">--%>
<%--                        <!-- 1. 댓글 목록-->--%>
<%--                        <div class="comment-group">--%>
<%--                            <div  id="commentListDiv">--%>
<%--                                <c:forEach items="${commentsList}" var="comment">--%>
<%--                                            <c:choose>--%>
<%--                                                <c:when test="${comment.orders == 0}"> &lt;%&ndash;                                            상위그룹&ndash;%&gt;--%>
<%--                                                    <div class="col-12 mt-3" style="margin-left: ${(comment.orders+1)*10}px" id="commentDiv${comment.commentsNo}">--%>
<%--                                                        <span class="mr-3">${comment.id}</span>--%>
<%--                                                        <span class="mr-3 commentsNo${comment.commentsNo}">${comment.commentsContent}</span>--%>
<%--                                                        <span class="mr-2"><fmt:formatDate value="${comment.commentsDate}" pattern="yyyy. MM. dd."/></span>--%>
<%--                                                        <span>--%>
<%--                                                            <img class="subCommentsBtn" src="/static/images/icons/comment.png" style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"--%>
<%--                                                                 onclick="subComments(${comment.commentsNo},${comment.orders+1})"/>--%>
<%--                                                            <c:if test="${sessionScope.loginUser.id == comment.id}">--%>
<%--                                                            <img src="/static/images/icons/modify.png" name="modifyComment"--%>
<%--                                                                 style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"--%>
<%--                                                                 onclick="modifyComments('${comment.commentsNo}');"/>--%>
<%--                                                            <img src="/static/images/icons/bin.png"--%>
<%--                                                                 style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"--%>
<%--                                                                 onclick="deleteComments(${comment.commentsNo});"/>--%>
<%--                                                            </c:if>--%>
<%--                                                        </span>--%>
<%--                                                    </div>--%>
<%--                                                </c:when>--%>
<%--                                                <c:otherwise> &lt;%&ndash;                                            하위그룹&ndash;%&gt;--%>
<%--                                                    <div class="col-12 mt-3" style="margin-left: ${(comment.orders+1)*30}px" id="commentDiv${comment.commentsNo}">--%>
<%--                                                        <img src="/../static/images/icons/subComment.png" style="width:15px; height:auto; vertical-align: middle;"/>--%>
<%--                                                        <span class="mr-3">${comment.id}</span>--%>
<%--                                                        <span class="mr-3 commentsNo${comment.commentsNo}">${comment.commentsContent}</span>--%>
<%--                                                        <span class="mr-2"><fmt:formatDate value="${comment.commentsDate}" pattern="yyyy. MM. dd."/></span>--%>
<%--                                                        <span>--%>
<%--                                                            <img class="subCommentsBtn" src="/static/images/icons/comment.png" style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"--%>
<%--                                                            onclick="subComments(${comment.commentsNo},${comment.orders+1})"/>--%>
<%--                                                             <c:if test="${sessionScope.loginUser.id == comment.id}">--%>
<%--                                                                <img src="/static/images/icons/modify.png" name="modifyComment"--%>
<%--                                                                    style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"--%>
<%--                                                                    onclick="modifyComments('${comment.commentsNo}');"/>--%>
<%--                                                                 <img src="/static/images/icons/bin.png"--%>
<%--                                                                      style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"--%>
<%--                                                                      onclick="deleteComments(${comment.commentsNo});"/>--%>
<%--                                                             </c:if>--%>
<%--                                                        </span>--%>
<%--                                                    </div>--%>
<%--                                                </c:otherwise>--%>
<%--                                            </c:choose>--%>
<%--                                </c:forEach>--%>
<%--                            </div>--%>
<%--                        </div>--%>


<%--                            <!-- 작성폼 -->--%>
<%--                            <label id="msgLabel"></label>--%>
<%--                            <form class="mb-4" id="createCommentsF" name="createCommentsF">--%>
<%--                                <div class="row">--%>
<%--                                    <div class="col-9">--%>
<%--                                        <textarea class="form-control" id="commentsContent" name="commentsContent"--%>
<%--                                                  row="3" placeholder="댓글을 남겨주세요"></textarea>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-3">--%>
<%--                                        <c:if test="${sessionScope.loginUser != null}">--%>
<%--                                        <input type="button" id="createCommentsBtn" onclick="createComments(0,0)"--%>
<%--                                               value="남기기">--%>
<%--                                        </c:if>--%>
<%--                                        <c:if test="${sessionScope.loginUser == null}">--%>
<%--                                        <input type="button" id="createCommentsBtn" onclick="location.href='/login'"--%>
<%--                                               value="남기기">--%>
<%--                                        </c:if>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </form>--%>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- content-wrapper ends -->
</div>
<!-- main-panel ends -->
<script>

    // 댓글창 입력 후 엔터키 => 검색
    $("#commentsContent").keyup(e => {
        if (e.keyCode === 13) {
            createComments(0,0);
            e.preventDefault();
        }
    });
    $(".subCommentText").keyup(e => {
        if (e.keyCode === 13) {
            createComments(0,0);
            e.preventDefault();
        }
    });


    /********************************  파일 다운로드 **********************************/
    function fileDownload(no){
        window.location.href='/downloadFile?fileNo='+no;
    }

    /******************************** 1. 댓글 작성 **********************************/
    //하위타입 댓글 작성
        //1) 작성 폼 나오기(상위댓글 아래에)
    function subComments(commentsNo,orders) {
        console.log("들어오니");
        $('.subCommentTextDiv').remove();
        let commentDiv = $('#commentDiv'+commentsNo);
        let html = "<div class ='subCommentTextDiv'><input class='subCommentText' style='margin-left: "+(orders+1)*30+"px' id=subCommentText"+commentsNo+" type='text' class='mr-3' value=''/>" +
            "<button onclick='createComments(" + commentsNo +","+orders+ ")'>답글달기</button>\n</div>";
        commentDiv.append(html);
    }

    //댓글 작성
    function createComments(no,ordersNo) {
        let commentsNo = no;
        let orders = ordersNo;
        let topCommentsContent = $('#commentsContent').val();
        let subCommentsContent = $('#subCommentText'+no).val();
        console.log(subCommentsContent);
        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/createComments-ajax',
            method: 'POST',
            dataType: 'json',
            data: {
                'commentsNo' : commentsNo,
                'topCommentsContent': topCommentsContent,
                'subCommentsContent' : subCommentsContent,
                'orders': orders,
                'boardNo': boardNo
            },
            success: function (resultJson) {
                console.log(resultJson);
                reload(resultJson);
                $('#commentsContent').val('');
            },
            error: function (e) {
                console.log(e);
                console.log('에러확인');
            },
            async: true
        });
    }

    /******************************** 2. 댓글 삭제 **********************************/
    function deleteComments(commentsNo) {
        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/deleteComment-ajax',
            method: 'POST',
            data: {
                'commentsNo': commentsNo,
                'boardNo': boardNo
            },
            success: function (resultJson) {
                reload(resultJson);
            },
            error: function (e) {
                console.log(e);
            },
            async: true
        });
    }

    /******************************** 3. 댓글 수정 **********************************/
    function modifyComments(commentsNo) {
        let commentsContent = $('.commentsNo'+commentsNo).text();
        $('.commentsNo' + commentsNo).empty();  //span 이름이 겹쳤음
        let html = "<input type='text' class='mr-3 subCommentText' id='modifyText"+commentsNo+"' value='"+commentsContent+"'/>" +
            "<button onclick='modifyCommentsAction(" + commentsNo + ")'>수정하기</button>";
        $('.commentsNo' + commentsNo).append(html);
    }

    function modifyCommentsAction(commentsNo) {
        let commentsContent = $('#modifyText' + commentsNo).val();    //왜 ""로 들어가지?
        console.log(commentsNo);
        console.log($('#commentsNo' + commentsNo));
        console.log(commentsContent);
        console.log($('#commentsNo' + commentsNo).val());

        console.log($('#commentsNo2').val());

        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/modifyComment-ajax',
            method: 'POST',
            data: {
                'commentsNo': commentsNo,
                'commentsContent': commentsContent,
                'boardNo': boardNo
            },
            success: function (resultJson) {
                reload(resultJson);
                $('#commentsContent').val('');
            },
            error: function (e) {
                alert(e);
            },
            async: true
        });
    }

    /******************************** 공통함수(댓글 다시 뿌리기) **********************************/
    function reload(resultData) {
        if (resultData.code === 1) {
            $('#commentListDiv').empty();
            let html = '';
            for (let i = 0; i < resultData.data.length; i++) {
                let dataItem = resultData.data[i];
                let date = new Date(dataItem.commentsDate).toLocaleDateString('ko-KR', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit'
                }).replace(/\./g, '.');
                console.log(dataItem);
                console.log(resultData.loginUser);
                if (dataItem.orders === 0) {
                    //부모댓글일 때 ==> orders=0
                    html += " <div class='col-12 mt-3' style='margin-left: 10px' id='commentDiv"+dataItem.commentsNo+"'>\n" +
                        "                                                    <span class='mr-3'>" + dataItem.id + "</span>\n" +
                        "                                                    <span class='mr-3 commentsNo" + dataItem.commentsNo + "'>" + dataItem.commentsContent + "</span>\n" +
                        "                                                    <span class='mr-2'>" + date + "</span>\n" +
                        "                                                    <span >\n" +
                        "                                                        <img src='/static/images/icons/comment.png' class='subCommentsBtn' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' onclick='subComments("+dataItem.commentsNo+","+(dataItem.orders+1)+")'/>\n";
                    if(dataItem.id == resultData.loginUser.id) {
                        html +=  "                                               <img src='/static/images/icons/modify.png' name='modifyComment' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' onclick='modifyComments(" + dataItem.commentsNo + ")'/>\n" +
                        "                                                        <img src='/static/images/icons/bin.png' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' onclick='deleteComments(" + dataItem.commentsNo + ")'/>\n";
                    }
                    html +="                                                    </span>\n" +
                        "                                                </div>\n";
                } else {
                    //답글일 때 ==> orders!=0
                    html += "                                                <div class='col-11' id='commentDiv"+dataItem.commentsNo+"' style='margin-left: "+(dataItem.orders+1)*30+"px'>\n" +
                        "                                                    <img src='/static/images/icons/subComment.png' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' />\n" +
                        "                                                    <span class='mr-3'>" + dataItem.id + "</span>\n" +
                        "                                                    <span class='mr-3 commentsNo" + dataItem.commentsNo + "'>" + dataItem.commentsContent + "</span>\n" +
                        "                                                    <span class='mr-2'>" + date + "</span>\n" +
                        "                                                    <span >\n" +
                        "                                                     <img src='/static/images/icons/comment.png' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' onclick='subComments("+dataItem.commentsNo+","+(dataItem.orders+1)+")'/>\n";
                    if(dataItem.id == resultData.loginUser.id) {
                        html +="                                                 <img src='/static/images/icons/modify.png' name='modifyComment' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' onclick='modifyComments(" + dataItem.commentsNo + ")'/>\n" +
                        "                                                        <img src='/../static/images/icons/bin.png' style='width:14px; height:auto; vertical-align: middle; cursor: pointer;' onclick='deleteComments(" + dataItem.commentsNo + ")'/>\n";
                    }
                    html +="                                                    </span>\n" +
                        "                                                </div>\n";
                }
            }
            $('#commentListDiv').append(html);
        } else {
            alert(resultData.msg);
        }
    }
</script>
