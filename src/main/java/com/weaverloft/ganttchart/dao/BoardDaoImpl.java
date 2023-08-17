package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.mapper.BoardMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public List<Board> findBoardList(int pageBegin, int pageEnd, String keyword) throws Exception {
        Map<String,Object> map=new HashMap<>();
        map.put("pageBegin", pageBegin);
        map.put("pageEnd", pageEnd);
        map.put("keyword",keyword);
        return boardMapper.findBoardList(map);
    }

    @Override
    public Board findByBoardNo(int boardNo) throws Exception {
        return boardMapper.findByBoardNo(boardNo);
    }

    @Override
    public int deleteBoard(int boardNo) throws Exception {
        return boardMapper.deleteBoard(boardNo);
    }

    @Override
    public int updateBoard(Board board) throws Exception {
        return boardMapper.updateBoard(board);
    }

    @Override
    public int findBoardCount() throws Exception {
        return boardMapper.findBoardCount();
    }

    @Override
    public int updateBoardReadcount(int boardNo) throws Exception {
        return boardMapper.updateBoardReadcount(boardNo);
    }

    @Override
    public int findCurKey() throws Exception {
        return boardMapper.findCurKey();
    }

    @Override
    public List<Board> findBoardTopList(int no) throws Exception{
        return boardMapper.findBoardTopList(no);
    }
}
