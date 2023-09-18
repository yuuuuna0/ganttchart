package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.mapper.BoardMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDaoImpl implements BoardDao{
    private BoardMapper boardMapper;

    public BoardDaoImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    @Override
    public List<Board> findBoardList() throws Exception {
        return boardMapper.findBoardList();
    }

    @Override
    public Board findBoardByNo(int boardNo) throws Exception {
        return boardMapper.findBoardByNo(boardNo);
    }

    @Override
    public int findCurNo() throws Exception {
        return boardMapper.findCurNo();
    }

    @Override
    public int createBoard(Board board) throws Exception {
        return boardMapper.createBoard(board);
    }

    @Override
    public int increaseReadCount(int boardNo) throws Exception {
        return boardMapper.increaseReadCount(boardNo);
    }

    @Override
    public int updateBoard(Board board) throws Exception {
        return boardMapper.updateBoard(board);
    }

    @Override
    public List<Board> findBoardByUId(String uId) throws Exception {
        return boardMapper.findBoardByUId(uId);
    }
}
