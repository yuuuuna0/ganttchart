package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.BoardFileDao;
import com.weaverloft.ganttchart.dto.BoardFile;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardFileServiceImpl implements BoardFileService {
    private BoardFileDao boardFileDao;

    public BoardFileServiceImpl(BoardFileDao boardFileDao) {
        this.boardFileDao = boardFileDao;
    }

    @Override
    public int createBoardFile(BoardFile boardFile) throws Exception {
        return boardFileDao.createBoardFile(boardFile);
    }

    @Override
    public List<BoardFile> findByBoardNo(int boardNo) throws Exception {
        return boardFileDao.findByBoardNo(boardNo);
    }

    @Override
    public BoardFile findFileByNo(int fileNo) throws Exception {
        return boardFileDao.findFileByNo(fileNo);
    }

    @Override
    public int deleteFile(int fileNo)  throws Exception{
        return boardFileDao.deleteFile(fileNo);
    }
}
