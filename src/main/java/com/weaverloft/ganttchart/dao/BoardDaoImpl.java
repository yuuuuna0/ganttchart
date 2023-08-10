package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.mapper.BoardMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class BoardDaoImpl implements BoardDao {
    private BoardMapper boardMapper;

    public BoardDaoImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    @Override
    public int createBoard(Board board) throws Exception {
        return boardMapper.createBoard(board);
    }

    @Override
    public List<Board> selectBoardList() throws Exception {
        return boardMapper.selectBoardList();
    }

    @Override
    public Board selectByBoardNo(int boardNo) throws Exception {
        return boardMapper.selectByBoardNo(boardNo);
    }

    @Override
    public int deleteBoard(int boardNo) throws Exception {
        return boardMapper.deleteBoard(boardNo);
    }

    @Override
    public int updateBoard(Board board) throws Exception {
        return boardMapper.updateBoard(board);
    }
}
