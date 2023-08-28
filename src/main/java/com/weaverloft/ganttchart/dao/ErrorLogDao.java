package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.ErrorLog;

public interface ErrorLogDao {
    //1. 로그 남기기
    int createLog(ErrorLog errorLog);
}
