package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Files;
import com.weaverloft.ganttchart.mapper.FilesMapper;
import org.springframework.stereotype.Repository;

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
    public int createFile(Files files) throws Exception {
        return filesMapper.createFile(files);
    }

    @Override
    public Files findFileByNo(int fileNo) throws Exception {
        return filesMapper.findFileByNo(fileNo);
    }
}
