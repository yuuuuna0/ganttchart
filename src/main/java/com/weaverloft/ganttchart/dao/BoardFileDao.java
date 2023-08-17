package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.BoardFile;

import java.util.List;

public interface BoardFileDao {
    int createBoardFile(BoardFile boardFile) throws Exception;

    List<BoardFile> findByBoardNo(int boardNo) throws Exception;
}
