package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Files;
import com.weaverloft.ganttchart.mapper.FilesMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FilesDaoImpl implements FilesDao{
    private FilesMapper filesMapper;

    public FilesDaoImpl(FilesMapper filesMapper) {
        this.filesMapper = filesMapper;
    }

    @Override
    public int findCurFileNo() throws Exception {
        return filesMapper.findCurFileNo();
    }

    @Override
    public int createFile(Files files,int fileType) throws Exception {
        if(fileType == 1)return filesMapper.createUserFile(files);
        if(fileType == 2)return filesMapper.createGathFile(files);
        if(fileType == 3)return filesMapper.createReviewFile(files);
        if(fileType == 4)return filesMapper.createBoardFile(files);
        return 0;
    }

    @Override
    public Files findFileByNo(int fileNo) throws Exception {
        return filesMapper.findFileByNo(fileNo);
    }

    @Override
    public List<Files> findFileByBoardNo(int boardNo) throws Exception {
        return filesMapper.findFileByBoardNo(boardNo);
    }

    @Override
    public List<Files> findFileByReviewNo(int reviewNo) throws Exception {
        return filesMapper.findFileByReviewNo(reviewNo);
    }

    @Override
    public List<Files> findFileByGathNo(int gathNo) throws Exception {
        return filesMapper.findFileByGathNo(gathNo);
    }
}
