package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.mapper.BoardMapper;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao{
    private BoardMapper boardMapper;

    public BoardDaoImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }
}
