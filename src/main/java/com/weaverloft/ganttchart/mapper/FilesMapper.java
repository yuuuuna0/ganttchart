package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Files;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FilesMapper {
    int findCurFileNo() throws Exception;

    int createFile(Files files) throws Exception;

    Files findFileByNo(int fileNo) throws Exception;
}
