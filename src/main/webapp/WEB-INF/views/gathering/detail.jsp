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
                        <div class="row">
                            <div class="col-8">
                                <h4 class="card-title">모임 상세보기</h4>
                            </div>
                            <div class="col-4 flex" style="display: flex; justify-content: flex-end;">
                                <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.getUId() == gath.getUId()}">
                                    <input type="button" id="gathCreateBtn" name="gathCreateBtn"
                                           class="btn btn-primary mr-2"
                                           onclick="location.href='/gathering/modify?gathNo=${gath.gathNo}'" value="수정">
                                    <input type="button" id="cancelBtn" name="cancelBtn" class="btn btn-light"
                                           onclick="location.href='/gathering/delete.action?gathNo=${gath.gathNo}'" value="삭제">
                                </c:if>
                                <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.auth == 'ROLE_USER'}">
                                    <input type="button" id="gathApplyBtn" name="gathApplyBtn"
                                           class="btn btn-primary mr-2"
                                           onclick="applyGath(${gath.gathNo})" value="신청하기">
                                </c:if><input type="button" id="listBtn" name="listBtn" class="btn btn-primary ml-2"
                                              onclick="location.href='/gathering/list?pageNo=1&keyword='" value="목록으로">
                            </div>
                        </div>
                        <br>
                        <div class="form-group row">
                            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-indicators">
                                    <c:forEach items="${gath.fileList}" varStatus="no">
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
                                    <c:forEach items="${gath.fileList}" var="file">
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
                        </div>
                        <div class="form-group row" >
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
                        </div>
                        <div class="form-group row" >
                            <div class="col-3">
                            <label for="gathDay">모임일</label>
                            <input  type="text" class="form-control" id="gathDay" name="gathDay"
                                     value='<fmt:formatDate value="${gath.gathDay}" pattern="yyyy. MM. dd."/>'  disabled>
                            </div>
                            <div class="col-3">
                            <label for="gathClose">모집마감일</label>
                            <input  type="text" class="form-control" id="gathClose" name="gathClose"
                                    value='<fmt:formatDate value="${gath.gathClose}" pattern="yyyy. MM. dd."/>' disabled>
                            </div>
                            <div class="col-3">
                            <label for="gathAmount">모집상태</label>
                                <c:choose>
                                    <c:when test="${gath.gathStatusNo == 1}"><input type="text" class="form-control" id="gathStatus" name="gathStatus" value="모집중" disabled></c:when>
                                    <c:when test="${gath.gathStatusNo == 2}"><input type="text" class="form-control" id="gathStatus" name="gathStatus" value="인원마감" disabled></c:when>
                                    <c:when test="${gath.gathStatusNo == 3}"><input type="text" class="form-control" id="gathStatus" name="gathStatus" value="모임완료" disabled></c:when>
                                </c:choose>
                            </div>
                            <div class="col-3">
                            <label for="gathAmount">잔여인원</label>
                            <input  type="text" class="form-control" id="gathAmount" name="gathAmount"
                                   value="${gath.gathAmount}" disabled>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-6">
                            <label for="gathDesc">내용</label>
                            <textarea class="form-control" id="gathDesc" name="gathDesc" rows="10"
                                      disabled>${gath.gathDesc}</textarea>
                            </div>
                            <div class="col-6" id="map" style="width:500px;height:400px;">
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                <c:if test="${sessionScope.loginUser.getUId() == gath.getUId()}">
                    <div class="row">
                        <div class="col-9">
                            <h4 class="card-title">신청리스트</h4>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>신청번호</th>
                                <th>프로필사진</th>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>생년월일</th>
                                <th>성별</th>
                                <th>신청일</th>
                                <th>신청상태</th>
                            </tr>
                            </thead>
                            <tbody id="applyTbody">
                            <c:forEach items="${applyList}" var="apply">
                                <tr style="cursor: pointer;" onmouseover="this.style.background='gray'" onmouseout="this.style.background='white'">
                                    <td>${apply.applyNo}</td>
                                    <td>
                                        <img class="img-fluid styled profile_pic rounded-circle"  width = "200px" src="/upload/user/${apply.users.file.saveName}"/>
                                    </td>
                                    <td>${apply.users.getUId()}</td>
                                    <td>${apply.users.getUName()}</td>
                                    <td><fmt:formatDate value="${apply.users.getUBirth()}" pattern="yyyy. MM. dd."/></td>
                                    <td>${apply.users.getUGender()}</td>
                                    <td><fmt:formatDate value="${apply.applyDate}" pattern="yyyy. MM. dd."/></td>
                                    <td>
                                        <select id="applyStatusNo" name="applyStatusNo" onchange="changeStatus(${apply.applyNo})">
                                            <option value="1" ${apply.applyStatusNo == 1 ? 'selected' : ''}>대기중</option>
                                            <option value="2" ${apply.applyStatusNo == 2 ? 'selected' : ''}>승인완료</option>
                                            <option value="3" ${apply.applyStatusNo == 3 ? 'selected' : ''}>거절</option>
                                        </select>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                    </div>
                    <hr>

<%-- 후기 --%>
                    <div class="card-body">
                        <h4 class="card-title">후기</h4>
                            <div class="form-group">
                                <label for="reviewList"></label>
                                <div id="reviewList">
                                    <c:forEach items="${reviewList}" var="review">
                                        <div class="form-group row" id="reviewNo${review.reviewNo}">
                                            <div class="col-2">
                                            ${review.getUId()}<span class="ml-3"><fmt:formatDate value="${review.reviewDate}" pattern="yyyy. MM. dd."/></span>
                                                <span>${review.reviewRating}점</span>
                                                <br>
                                            ${review.reviewContent}
                                            </div>
                                            <c:forEach items="${review.fileList}" var="file">
                                            <div class="col-2">
                                                <img src="/upload/review/${file.saveName}">
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </c:forEach>
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
    //모임 신청하기
    function applyGath(no){
        let gathNo = no;
        $.ajax({
            url : '/gathering/apply.ajx',
            method : 'POST',
            data : {
                'gathNo' : gathNo
            },
            success : function (resultMap){
                if(resultMap.code == 1){
                    alert(resultMap.msg);
                } else{
                    alert(resultMap.msg);
                }
            },
            error : function(e){
                console.log(e);
            }
        });
    }

    //카카오 지도 출력
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스.
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
        level: 3 //지도의 레벨(확대, 축소 정도)
    };
    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var geocoder = new kakao.maps.services.Geocoder();  // 주소-좌표 변환 객체를 생성합니다
    let addr = '${gath.gathAddr}';
    geocoder.addressSearch(addr, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
            map.setCenter(coords);
        }
    });

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
    //신청상태 변경
    function changeStatus(no){
        let applyStatusNo = $('#applyStatusNo option:selected').val();
        let gathNo = ${gath.gathNo};
        debugger;
        $.ajax({
            url : '/gathering/apply/change.ajx',
            method : 'POST',
            data : {
                'applyStatusNo' : applyStatusNo,
                'applyNo' : no,
                'gathNo' : gathNo
            },
            success : function(resultMap){
                if(resultMap.code === 1){
                    alert("신청상태 변경");
                    $('#gathAmount').val(${gath.gathAmount}-resultMap.acceptedPerson);
                }
            },
            error : function(e){
                console.log(e);
            }
        });

    }


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