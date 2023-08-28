package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.ErrorLog;

public interface ErrorLogMapper {
    //1. 로그 남기기
    int createLog(ErrorLog errorLog);
}
