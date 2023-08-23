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
                                <h4 class="card-title">게시글 상세보기</h4>
                                <div class="form-group">
                                    <label for="boardTitle">제목</label>
                                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" disabled>
                                </div>
                                <div class="form-group">
                                    <label for="boardContent">내용</label>
                                    <textarea class="form-control" id="boardContent" name="boardContent" rows="4" disabled>${board.boardContent}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="fileList">첨부파일</label>
                                    <div class="input-group col-xs-12">
                                        <div style="width: 500px; height: 200px; padding: 10px; overflow: auto; border: 1px solid #989898;" id="fileList" >
                                            <c:forEach items="${boardFileList}" var="boardFile">
                                                <div id="file'+ fileNo + '" style="font-size:12px;">
                                                        ${boardFile.fileName}
                                                    <img src="/resources/static/images/icon_download.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;"/>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <c:if test="${session.loginUser != null && session.loginUser.id == board.id}">
                                    <div style="text-align: right">
                                        <input type="button" id="boardCreateBtn" name="boardCreateBtn" class="btn btn-primary mr-2" onclick="location.href='/board/modify/${board.boardNo}'" value="수정">
                                        <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light" onclick="location.href='/board/delete-action/${board.boardNo}'" value="삭제">
                                    </div>
                                    </c:if>
                                </div>
                            </div>
                            <hr>
                            <!-- 댓글 시작 -->
                            <div class="card-body" >
                                <input type="hidden" value="${board.boardNo}" id="boardNo">
                                <!-- 1. 댓글 목록-->
                                <div class="comment-group">
                                    <div class="row" id="commentListDiv">
                                        <c:forEach items="${commentsList}" var="comment">
                                            <input type="hidden" value="${comment.commentsNo}" id="commentsNo">
                                            <c:if test="${comment.classNo == 1}">
                                                <div class="col-12 mt-3">
                                                    <span class="mr-3">${comment.id}</span>
                                                    <span class="mr-3" id="commentsNo${comment.commentsNo}">${comment.commentsContent}</span>
                                                    <span class="mr-2"><fmt:formatDate value="${comment.commentsDate}" pattern="yyyy. MM. dd."/></span>
                                                    <span >
                                                        <img src="../../../resources/static/images/icon_comment.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" onclick="subComments('${comment.id}')"/>
                                                        <img src="../../../resources/static/images/icon_modify.png" name="modifyComment" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" onclick="modifyComments(${comment.commentsNo},'${comment.commentsContent}');"/>
                                                        <img src="../../../resources/static/images/icon_bin.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" onclick="deleteComments(${comment.commentsNo});"/>
                                                    </span>
                                                </div>
                                            </c:if>
                                            <c:if  test="${comment.classNo == 2}">
                                                <div class="col-1">
                                                    &nbsp
                                                </div>
                                                <div class="col-11">
                                                    <img src="../../../resources/static/images/icon_subComment.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" />
                                                    <span class="mr-3">${comment.id}</span>
                                                    <span class="mr-3" id="commentsNo${comment.commentsNo}">${comment.commentsContent}</span>
                                                    <span class="mr-2"><fmt:formatDate value="${comment.commentsDate}" pattern="yyyy. MM. dd."/></span>
                                                    <span>
                                                        <img src="../../../resources/static/imagess/icon_modify.png" name="modifyComment" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" onclick="modifyComments(${comment.commentsNo},${comment.commentsContent});"/>
                                                        <img src="../../../resources/static/images/icon_bin.png" style="width:15px; height:auto; vertical-align: middle; cursor: pointer;" onclick="deleteComments(${comment.commentsNo});"/>
                                                    </span>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>

                                <hr>
                                <c:if test="${session.loginUser != null}">
                                <!-- 작성폼 -->
                                <label id="msgLabel" ></label>
                                <form class="mb-4" id="createCommentsF" name="createCommentsF">
                                    <div class="row">
                                        <div class="col-9">
                                            <textarea class="form-control" id="commentsContent" name="commentsContent" row="3" placeholder="댓글을 남겨주세요"></textarea>
                                        </div>
                                        <div class="col-3">
                                            <input type="button" id="createCommentsBtn" onclick="createComments(1)" value="남기기">
                                        </div>
                                    </div>
                                </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- main-panel ends -->
<script>






    /******************************** 1. 댓글 작성 **********************************/
    //하위타입 댓글 작성
    function subComments(e,id){
        console.log(e.target.parentElement);
        $('#commentsContent').focus();
        $('#msgLabel').text(id+'님에게 댓글 다는 중,,,,');
        $('#createCommentsBtn').prop('onclick','createComments(2)');    //-> classNo 2 넘기는 방법?
    }

    //상위타입 댓글 작성
    function createComments(classNo){
        let commentsContent = $('#commentsContent').val();
        let boardNo = $('#boardNo').val();
        $.ajax({
            url : '/createComments-ajax',
            method : 'POST',
            dataType : 'json',
            data : {
                'commentsContent' : commentsContent,
                'classNo' : classNo,
                'boardNo' : boardNo
            },
            success : function(resultJson){
                console.log(resultJson);
                reload(resultJson);
            },
            error : function(e){
                console.log(e);
                console.log('에러확인');
            },
            async : true
        });
    }
    /******************************** 2. 댓글 삭제 **********************************/
    function deleteComments(commentsNo){
        let boardNo = $('#boardNo').val();
        $.ajax({
            url : '/deleteComment-ajax',
            method : 'POST',
            data : {
                'commentsNo' : commentsNo,
                'boardNo' : boardNo
            },
            success : function(resultJson){
                reload(resultJson);
            },
            error : function (e) {
                console.log(e);
            },
            async : true
        });
    }
    /******************************** 3. 댓글 수정 **********************************/
    function modifyComments(commentsNo,commentsContent){
        $('#commentsNo'+commentsNo).empty();
        let html = "<input type='text' class='mr-3' id='commentsNo"+commentsNo+"' value='"+commentsContent+"'/>"+
            "<button onclick='modifyCommentsAction("+commentsNo+")'>수정하기</button>";
        $('#commentsNo'+commentsNo).append(html);
    }
    // //수정하는 댓글 색만 변경하기
    // $('img[name="modifyComment"]').click(function(){
    //     $('.mr-3').css('color','black');
    //     $(this).css('color','red');
    // });

    function modifyCommentsAction(commentsNo) {
        let commentsContent = $('#commentsNo'+commentsNo).val();    //왜 ""로 들어가지?
        let boardNo = $('#boardNo').val();
        $.ajax({
            url: '/modifyComment-ajax',
            method: 'POST',
            data: {
                'commentsNo' : commentsNo,
                'commentsContent' : commentsContent,
                'boardNo' : boardNo
            },
            success: function(resultJson){
                reload(resultJson);
            },
            error : function(e){
                alert(e);
            },
            async : true
        });
    }

    /******************************** 공통함수(댓글 다시 뿌리기) **********************************/
    function reload(resultData){
        if(resultData.code === 1){
            $('#commentListDiv').empty();
            let html = '';
            for(let i=0; i<resultData.data.length ;i++){
                let dataItem = resultData.data[i];
                let date = new Date(dataItem.commentsDate).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '.');
                if(dataItem.classNo === 1){
                    //부모댓글일 때 ==> classNo=1
                    html += " <div class='col-12 mt-3' >\n" +
                        "                                                    <span class='mr-3'>"+dataItem.id+"</span>\n" +
                        "                                                    <span class='mr-3' id='commentsNo"+dataItem.commentsNo+"'>"+dataItem.commentsContent+"</span>\n" +
                        "                                                    <span class='mr-2'>"+date+"</span>\n" +
                        "                                                    <span >\n" +
                        "                                                        <img src='/resources/static/images/icon_comment.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='createComments(2)'/>\n" +
                        "                                                        <img src='/resources/static/images/icon_modify.png' name='modifyComment' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='modifyComments("+dataItem.commentsNo+","+dataItem.commentsContent+")'/>\n" +
                        "                                                        <img src='/resources/static/images/icon_bin.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='deleteComments("+dataItem.commentsNo+")'/>\n" +
                        "                                                    </span>\n" +
                        "                                                </div>\n";
                } else{
                    //답글일 때 ==> classNo=2
                    html += " <div class='col-1'>\n" +
                        "                                                    &nbsp\n" +
                        "                                                </div>\n" +
                        "                                                <div class='col-11'>\n" +
                        "                                                    <img src='/resources/static/images/icon_subComment.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' />\n" +
                        "                                                    <span class='mr-3'>"+dataItem.id+"</span>\n" +
                        "                                                    <span class='mr-3' id='commentsNo"+dataItem.commentsNo+"'>"+dataItem.commentsContent+"</span>\n" +
                        "                                                    <span class='mr-2'>"+date+"</span>\n" +
                        "                                                    <span >\n" +
                        "                                                        <img src='/resources/static/images/icon_modify.png' name='modifyComment' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='modifyComments("+dataItem.commentsNo+","+dataItem.commentsContent+")'/>\n" +
                        "                                                        <img src='/resources/static/images/icon_bin.png' style='width:15px; height:auto; vertical-align: middle; cursor: pointer;' onclick='deleteComments("+dataItem.commentsNo+")'/>\n" +
                        "                                                    </span>\n" +
                        "                                                </div>\n";
                }
            }
            $('#commentListDiv').append(html);
        } else {
            alert(resultData.msg);
        }
    }
</script>
</html>