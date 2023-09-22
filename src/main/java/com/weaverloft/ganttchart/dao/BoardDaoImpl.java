package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.mapper.BoardMapper;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public List<Board> findTopNBoard(int index) throws Exception {
        return boardMapper.findTopNBoard(index);
    }

    @Override
    public int countBoard(String keyword) throws Exception{
        return boardMapper.countBoard(keyword);
    }

    @Override
    public List<Board> findBoardList2(int contentBegin, int contentEnd, String keyword, String filterType, String ascDesc) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("contentBegin",contentBegin);
        map.put("contentEnd",contentEnd);
        map.put("keyword",keyword);
        map.put("filterType",filterType);
        map.put("ascDesc",ascDesc);
        return boardMapper.findBoardList2(map);
    }
}
