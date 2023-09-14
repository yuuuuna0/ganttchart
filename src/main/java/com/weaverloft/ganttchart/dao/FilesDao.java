package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Files;

public interface FilesDao {
    int findCurFileNo() throws Exception;

    int createFile(Files files) throws Exception;

    Files findFileByNo(int fileNo) throws Exception;
}
