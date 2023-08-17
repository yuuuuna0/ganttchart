package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    //1. 게시글 쓰기
    int createBoard(Board board) throws Exception;
    //2. 게시글 전체 리스트 보기 --> 페이징처리 필요
    List<Board> findBoardList(Map<String,Object> map) throws Exception;
    //3. 게시글 상세보기
    Board findByBoardNo(int boardNo) throws Exception;
    //4. 게시글 삭제
    int deleteBoard(int boardNo) throws Exception;
    //5. 게시글 수정
    int updateBoard(Board board) throws Exception;
    //6. 게시글 전체 개수
    int findBoardCount() throws Exception;
    //7. 게시글 조회수 1 올리기
    int updateBoardReadcount(int boardNo) throws Exception;
    //8. 최근 값 불러오기
    int findCurKey() throws Exception;
    //9. 조회수 상위 5개 불러오기
    List<Board> findBoardTopList(int no) throws Exception;
}
