package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.ErrorLog;

public interface ErrorLogDao {
    int createLog(ErrorLog errorLog);
}
