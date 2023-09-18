package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Board;

import java.util.List;

public interface BoardService {
    List<Board> findBoardList() throws Exception;

    Board findBoardByNo(int boardNo) throws Exception;

    int findCurNo() throws Exception;

    int createBoard(Board board) throws Exception;

    int increaseReadCount(int boardNo) throws Exception;

    int updateBoard(Board board) throws Exception;

    List<Board> findBoardByUId(String uId) throws Exception;
}
