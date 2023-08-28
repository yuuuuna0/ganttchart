package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.ErrorLog;

import javax.servlet.http.HttpSession;

public interface ErrorLogService {
    //1. 로그 남기기
    int createLog(ErrorLog errorLog);
}
