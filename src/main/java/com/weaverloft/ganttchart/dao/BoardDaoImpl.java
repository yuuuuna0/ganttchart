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
    public List<Board> selectBoardList(int pageBegin, int pageEnd, String keyword) throws Exception {
        Map<String,Object> map=new HashMap<>();
        map.put("pageBegin", pageBegin);
        map.put("pageEnd", pageEnd);
        map.put("keyword",keyword);
        return boardMapper.selectBoardList(map);
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

    @Override
    public int findBoardCount() throws Exception {
        return boardMapper.findBoardCount();
    }
}
