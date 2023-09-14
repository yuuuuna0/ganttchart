package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.BoardDao;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService{
    private BoardDao boardDao;

    public BoardServiceImpl(BoardDao boardDao) {
        this.boardDao = boardDao;
    }
}
