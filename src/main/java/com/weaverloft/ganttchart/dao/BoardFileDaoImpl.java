package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.BoardFile;
import com.weaverloft.ganttchart.mapper.BoardFileMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardFileDaoImpl implements BoardFileDao {
    private BoardFileMapper boardFileMapper;

    public BoardFileDaoImpl(BoardFileMapper boardFileMapper) {
        this.boardFileMapper = boardFileMapper;
    }

    @Override
    public int createBoardFile(BoardFile boardFile) throws Exception {
        return boardFileMapper.createBoardFile(boardFile);
    }

    @Override
    public List<BoardFile> findByBoardNo(int boardNo) throws Exception{
        return boardFileMapper.findByBoardNo(boardNo);
    }

    @Override
    public BoardFile findFileByNo(int fileNo) throws Exception {
        return boardFileMapper.findFileByNo(fileNo);
    }

    @Override
    public int deleteFile(int fileNo) throws Exception{
        return boardFileMapper.deleteFile(fileNo);
    }
}
