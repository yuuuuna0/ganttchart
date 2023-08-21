package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Comments;

import java.util.List;
import java.util.Map;

public interface CommentsDao {
    //1. 게시글 번호로 댓글리스트 찾기
    List<Comments> findCommentsByBoardNo(int boardNo) throws Exception;
    //2. 댓글번호로 댓글 찾기
    Comments findCommentsByCommentsNo(int CommentsNo) throws Exception;
    //3. 댓글 남기기
    int createComments(Comments comments) throws Exception;
    //4. 같은 그룹의 댓글 개수
    int findCommentsCountByGroupNo(int groupNo) throws Exception;
    //5. 최근 pk값 불러오기
    int findCurCommentsNo() throws Exception;
    //6. 모댓글 groupNo 업데이트
    int updateGroupNo(int curKey);
}
