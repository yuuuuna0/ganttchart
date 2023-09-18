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
                    <input type="hidden" value="${board.boardNo}" id="boardNo">
                    <div class="card-body">
                        <div class="row">
                        <div class="col-8">
                            <h4 class="card-title">게시글 상세보기</h4>
                        </div>
                        <div class="col-4 flex" style="display: flex; justify-content: flex-end;">
                            <%--                                    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.getUId() == board.getUId()}">--%>
                            <input type="button" id="boardCreateBtn" name="boardCreateBtn"
                                   class="btn btn-primary mr-2"
                                   onclick="location.href='/board/modify?boardNo=${board.boardNo}'" value="수정">
                            <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light"
                                   onclick="location.href='/board/delete.action?boardNo=${board.boardNo}'" value="삭제">
                            <%--                                    </c:if>--%>
                            <input type="button" id="listBtn" name="listBtn" class="btn btn-primary ml-2"
                                   onclick="location.href='/board/list?pageNo=1&keyword='" value="목록으로">
                        </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-6">
                            <label for="boardTitle">제목</label>
                            <input type="text"  class="form-control" id="boardTitle" name="boardTitle"
                                   value="${board.boardTitle}" disabled>
                            </div>
                            <div class="col-6">
                                <label for="readCount">조회수</label>
                                <input style=" display: flex; justify-content: flex-end; " type="text" class="form-control flex" id="readCount" name="readCount"
                                       value="${board.boardReadcount}" disabled>
                            </div>
                        </div>
                        <div class="form-group row" >
                            <div class="col-6">
                            <label for="name">작성자</label>
                            <input  type="text" class="form-control" id="name" name="name"
                                   value="${user.getUName()}" disabled>
                            </div>
                            <div class="col-6">
                            <label for="date">작성일</label>
                            <input  type="text" class="form-control" id="date" name="date"
                                   value="<fmt:formatDate value="${board.boardDate}" pattern="yyyy. MM. dd."/>" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="boardContent">내용</label>
                            <textarea  class="form-control" id="boardContent" name="boardContent" rows="4"
                                      disabled>${board.boardContent}</textarea>
                        </div>
                        <div class="form-group row">
                            <div class="col-5">
                            <label for="fileList">첨부파일</label>
                            <div class="input-group col-xs-12">
                                <div style="width: 100%; height: auto; padding: 10px; overflow: auto; border: 1px solid #989898;"
                                     id="fileList">
                                    <c:forEach items="${fileList}" var="file">
                                        <div id="file'+ fileNo + '" style="font-size:12px;">
                                                ${file.originalName}
                                                    <span style="margin-left: 3px"><fmt:parseNumber value="${file.fileSize/1000}" integerOnly="true" /> kb</span>
                                                    <span>
                                            <img  src="/../static/images/icons/download.png"
                                                 style="width:15px; height:auto; vertical-align: middle; cursor: pointer; margin-left: 3px" onclick="fileDownload(${file.fileNo});"/></span>

                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            </div>

                        </div>
                    </div>
                    <hr>
<%--                    <!-- 댓글 시작 -->--%>
                    <div class="card-body" style="padding-top: 0;">

                    <!-- 작성폼 -->
                    <label createCommentsF="후기">후기</label>
                    <form class="mb-4" id="createCommentsF" name="createCommentsF">
                        <div class="row">
                            <div class="col-9">
                                        <textarea class="form-control" id="commentsContent" name="commentsContent"
                                                  row="3" placeholder="댓글을 남겨주세요"></textarea>
                            </div>
                            <div class="col-3">
                                <c:if test="${sessionScope.loginUser != null}">
                                    <input type="button" id="createCommentsBtn" onclick="createComments(0,0,0,0)"
                                           value="남기기">
                                </c:if>
                                <c:if test="${sessionScope.loginUser == null}">
                                    <input type="button" id="createCommentsBtn" onclick="location.href='/user/login'"
                                           value="남기기">
                                </c:if>
                            </div>
                        </div>
                    </form>




<%--                        댓글 시작--%>
                        <div class="commentListDiv">
                            <c:forEach items="${preCommentList}" var="preComment">
                                <div class="col-12 mt-3" style="margin-left: 10px" id="groupDiv${preComment.groupNo}">
                                    <div id="commentDiv${preComment.commentsNo}">
                                    <span class="mr-3">${preComment.getUId()}</span>
                                    <span class="mr-3 commentsNo${preComment.commentsNo}">${preComment.commentsContent}</span>
                                    <span class="mr-2"><fmt:formatDate value="${preComment.commentsDate}" pattern="yyyy. MM. dd."/></span>
                                    <span>
                                        <img class="subCommentsBtn" src="/static/images/icons/comment.png" style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"
                                             onclick="subComments(${preComment.commentsNo},${preComment.groupNo},${preComment.depth+1},${preComment.orders+1})"/>
                                        <c:if test="${sessionScope.loginUser.getUId() == preComment.getUId()}">
                                        <img src="/static/images/icons/modify.png"
                                              style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"
                                              onclick="modifyComments('${preComment.commentsNo}');"/>
                                        <img src="/static/images/icons/bin.png"
                                             style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"
                                             onclick="deleteComments(${preComment.commentsNo});"/>
                                        </c:if>
                                    </span>
                                    </div>
                                    <c:forEach items="${commentList}" var="comment">
                                        <c:if test="${preComment.groupNo == comment.groupNo && comment.depth != 0}">
                                            <div class="col-12 mt-1" style="margin-left: ${(comment.depth+1)*15}px" id="commentDiv${comment.commentsNo}">
                                                <img src="/../static/images/icons/subComment.png" style="width:15px; height:auto; vertical-align: middle;"/>
                                                <span class="mr-3">${comment.getUId()}</span>
                                                <span class="mr-3 commentsNo${comment.commentsNo}">${comment.commentsContent}</span>
                                                <span class="mr-2"><fmt:formatDate value="${comment.commentsDate}" pattern="yyyy. MM. dd."/></span>
                                                <span>
                                                    <img class="subCommentsBtn" src="/static/images/icons/comment.png" style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"
                                                         onclick="subComments(${comment.commentsNo},${preComment.groupNo},${comment.depth+1},${comment.orders+1})"/>
                                                    <c:if test="${sessionScope.loginUser.getUId() == comment.getUId()}">
                                                    <img src="/static/images/icons/modify.png"
                                                         style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"
                                                         onclick="modifyComments('${comment.commentsNo}');"/>
                                                    <img src="/static/images/icons/bin.png"
                                                         style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"
                                                         onclick="deleteComments(${comment.commentsNo});"/>
                                                    </c:if>
                                                </span>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:forEach>

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
        window.location.href='/board/downloadFile?fileNo='+no;
    }

    /******************************** 1. 댓글 작성 **********************************/
    //하위타입 댓글 작성
        //1) 작성 폼 나오기(상위댓글 아래에)
    function subComments(commentsNo,groupNo,depth,orders) {
        $('.subCommentContent').remove();
        let commentDiv = $('#commentDiv'+commentsNo);
        let html = "<div class ='subCommentContent'><input class='subCommentText' style='margin-left: "+(orders+1)*30+"px' id='subCommentsContent"+commentsNo+"' type='text' class='mr-3' value=''/>" +
            "<button onclick='createComments(" + commentsNo +","+groupNo+","+depth+","+orders+ ")'>답글달기</button>\n</div>";
        commentDiv.append(html);
    }

    //댓글 작성
    function createComments(commentsNo2,groupNo2,depth2,orders2) {
        let groupNo = groupNo2;
        let depth = depth2;
        let orders = orders2;
        let commentsContent;
        if(depth2 === 0){
            commentsContent = $('#commentsContent').val();
        } else {
            commentsContent = $('#subCommentsContent'+commentsNo2).val();
        }
        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/board/comment/create.ajx',
            method: 'POST',
            data: {
                'groupNo' : groupNo,
                'commentsContent': commentsContent,
                'depth': depth,
                'orders' : orders,
                'boardNo': boardNo
            },
            success: function (resultJson) {
                console.log(resultJson);
                reload(resultJson);
                $('#commentsContent').val('');
            },
            error: function (e) {
                console.log(e);
            },
            async: true
        });
    }

    /******************************** 2. 댓글 삭제 **********************************/
    function deleteComments(commentsNo) {
        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/board/comment/delete.ajx',
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
            url: '/board/comment/modify.ajx',
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
    function reload(resultMap) {
        if (resultMap.code === 1) {
            $('.commentListDiv').empty();
            let html = '';
            for (let i = 0; i < resultMap.preCommentList.length; i++) {
                let preComment = resultMap.preCommentList[i];
                let date = new Date(preComment.commentsDate).toLocaleDateString('ko-KR', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit'
                }).replace(/\./g, '.');
            html += '<div class="col-12 mt-3" style="margin-left: 10px" id="groupDiv'+preComment.groupNo+'}">'
                +' <div id="commentDiv'+preComment.commentsNo+'">'
                +' <span class="mr-3">'+preComment.uId+'</span>'
                +' <span class="mr-3 commentsNo'+preComment.commentsNo+'">'+preComment.commentsContent+'</span>'
                +' <span class="mr-2">'+date+'</span>'
                +' <span>'
                +' <img class="subCommentsBtn" src="/static/images/icons/comment.png" style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"'
                +' onclick="subComments('+preComment.commentsNo+','+preComment.groupNo+','+(preComment.depth+1)+','+(preComment.orders+1)+'"/>'
                if(resultMap.loginUser.uId === preComment.uId){
                    html += '<img src="/static/images/icons/modify.png"'
                        +' style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"'
                        +' onclick="modifyComments('+preComment.commentsNo+');"/>'
                        +'<img src="/static/images/icons/bin.png"'
                        +' style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"'
                        +' onclick="deleteComments('+preComment.commentsNo+');"/>'
                }
                 +'</span>'
                 +'</div>'
                 for(let j=0;j<resultMap.commentList.length;j++){
                     let comment = resultMap.commentList[i];
                     let date2 = new Date(comment.commentsDate).toLocaleDateString('ko-KR', {
                         year: 'numeric',
                         month: '2-digit',
                         day: '2-digit'
                     }).replace(/\./g, '.');
                     if(preComment.groupNo === comment.groupNo && comment.depth !== 0){
                         html += '<div class="col-12 mt-1" style="margin-left: '+(comment.depth+1)*15+'px" id="commentDiv'+comment.commentsNo+'">'
                             +'<img src="/../static/images/icons/subComment.png" style="width:15px; height:auto; vertical-align: middle;"/>'
                             +'<span class="mr-3">'+comment.getUId()+'</span>'
                             +'<span class="mr-3 commentsNo'+comment.commentsNo+'">'+comment.commentsContent+'</span>'
                             +'<span class="mr-2">'+date2+'</span>'
                             +'<span>'
                             +'<img class="subCommentsBtn" src="/static/images/icons/comment.png" style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"'
                             +'onclick="subComments('+comment.commentsNo+','+preComment.groupNo+','+comment.depth+1+','+comment.orders+1+')"/>'
                         if(resultMap.loginUser.uId === comment.uId){
                             html += '<img src="/static/images/icons/modify.png"'
                                 +' style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"'
                                 +' onclick="modifyComments('+comment.commentsNo+');"/>'
                                 +'<img src="/static/images/icons/bin.png"'
                                 +' style="width:14px; height:auto; vertical-align: middle; cursor: pointer;"'
                                 +' onclick="deleteComments('+comment.commentsNo+');"/>'
                         }
                         +'</span>'
                         +'</div>'
                         +'</div>'
                     }
                    }
            }
            $('.commentListDiv').append(html);
        } else {
            alert(resultMap.msg);
        }
    }
</script>