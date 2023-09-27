package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.util.SearchDto;

import java.util.Date;
import java.util.List;

public interface BoardService {
    List<Board> findBoardList() throws Exception;

    Board findBoardByNo(int boardNo) throws Exception;

    int findCurNo() throws Exception;

    int createBoard(Board board) throws Exception;

    int increaseReadCount(int boardNo) throws Exception;

    int updateBoard(Board board) throws Exception;

    List<Board> findBoardByUId(String uId) throws Exception;

    List<Board> findTopNBoard(int index) throws Exception;

    SearchDto<Board> findSearchedUserList(int pageNo, String keyword, String filterType, String ascDesc) throws Exception;

    int countNewBoardPerDay(Date time) throws Exception;

    int deleteBoard(int boardNo) throws Exception;
}
