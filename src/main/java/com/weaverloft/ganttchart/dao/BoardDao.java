package com.weaverloft.ganttchart.dao;


import com.weaverloft.ganttchart.dto.Board;

import java.util.List;

public interface BoardDao {
    //1. 게시글 쓰기
    int createBoard(Board board) throws Exception;
    //2. 게시글 전체 리스트 보기 --> 페이징처리 필요
    List<Board> selectBoardList() throws Exception;
    //3. 게시글 상세보기
    Board selectByBoardNo(int boardNo) throws Exception;
    //4. 게시글 삭제
    int deleteBoard(int boardNo) throws Exception;
    //5. 게시글 수정
    int updateBoard(Board board) throws Exception;
}
