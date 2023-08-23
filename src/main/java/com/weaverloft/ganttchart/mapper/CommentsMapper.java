package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Comments;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommentsMapper {
    //1. 게시글 번호로 댓글리스트 찾기
    List<Comments> findCommentsByBoardNo(Map<String,Object> map) throws Exception;
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
    //7. 댓글 삭제
    int deleteComments(int commentsNo) throws Exception;
    //8. 댓글번호로 댓글 찾기
    Comments findCommentByCommentsNo(int commentsNo);
    //9. 댓글내용 수정
    int updateComments(Map<String,Object> map) throws Exception;
}
