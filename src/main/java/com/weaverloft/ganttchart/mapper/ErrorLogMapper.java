package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.ErrorLog;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ErrorLogMapper {

    int createLog(ErrorLog errorLog);
}
