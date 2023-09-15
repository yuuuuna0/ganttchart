package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.BoardDao;
import com.weaverloft.ganttchart.dto.Board;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{
    private BoardDao boardDao;

    public BoardServiceImpl(BoardDao boardDao) {
        this.boardDao = boardDao;
    }

    @Override
    public List<Board> findBoardList() throws Exception {
        return boardDao.findBoardList();
    }

    @Override
    public Board findBoardByNo(int boardNo) throws Exception {
        return boardDao.findBoardByNo(boardNo);
    }

    @Override
    public int findCurNo() throws Exception {
        return boardDao.findCurNo();
    }

    @Override
    public int createBoard(Board board) throws Exception {
        return boardDao.createBoard(board);
    }

    @Override
    public int increaseReadCount(int boardNo) throws Exception {
        return boardDao.increaseReadCount(boardNo);
    }

    @Override
    public int updateBoard(Board board) throws Exception {
        return boardDao.updateBoard(board);
    }
}
