package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    List<Board> findBoardList() throws Exception;

    Board findBoardByNo(int boardNo) throws Exception;

    int findCurNo() throws Exception;

    int createBoard(Board board) throws Exception;

    int increaseReadCount(int boardNo) throws Exception;

    int updateBoard(Board board) throws Exception;

    List<Board> findBoardByUId(String uId) throws Exception;
}
