package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Board;

import java.util.List;

public interface BoardDao {
    List<Board> findBoardList() throws Exception;

    Board findBoardByNo(int boardNo) throws Exception;

    int findCurNo() throws Exception;

    int createBoard(Board board) throws Exception;

    int increaseReadCount(int boardNo) throws Exception;

    int updateBoard(Board board) throws Exception;

    List<Board> findBoardByUId(String uId) throws Exception;

    List<Board> findTopNBoard(int index) throws Exception;

    int countBoard(String keyword) throws Exception;

    List<Board> findBoardList2(int contentBegin, int contentEnd, String keyword, String filterType, String ascDesc) throws Exception;
}
