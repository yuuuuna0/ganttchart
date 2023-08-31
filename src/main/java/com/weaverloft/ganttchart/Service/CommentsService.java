package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Comments;

import java.util.List;

public interface CommentsService {
    //1. 게시글 번호로 댓글 리스트 찾기
    List<Comments> findCommentsByBoardNo(int boardNo) throws Exception;
    //2. 댓글 달기
    int createComments(Comments comments) throws Exception;
    //3. 같은 그룹의 댓글 개수
    int findCommentsCountByGroupNo(int groupNo) throws Exception;
    //4. 최근 pk 값 불러오기
    int findCurCommentsNo() throws Exception;
    //5. 모댓글 groupNo 업데이트
    int updateGroupNo(int curKey);
    //6. 댓글 삭제
    int deleteComments(int commentsNo) throws Exception;
    //7. 댓글번호로 댓글 찾기
    Comments findCommentByCommentsNo(int commentsNo) throws Exception;
    //8. 댓글 내용 수정
    int updateComments(int commentsNo,String commentsContent) throws Exception;
    //10. 모든 코멘트 찾기
    List<Comments> findAllComments() throws Exception;
    //그룹넘버로 탑코멘트 찾기
    Comments findTopCommentByGroupNo(int groupNo);
}
