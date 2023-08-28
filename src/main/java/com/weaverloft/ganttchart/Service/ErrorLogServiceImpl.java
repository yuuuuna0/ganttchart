package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.ErrorLogDao;
import com.weaverloft.ganttchart.dto.ErrorLog;
import org.springframework.stereotype.Service;

@Service
public class ErrorLogServiceImpl implements ErrorLogService{
    private ErrorLogDao errorLogDao;

    public ErrorLogServiceImpl(ErrorLogDao errorLogDao) {
        this.errorLogDao = errorLogDao;
    }


    @Override
    public int createLog(ErrorLog errorLog) throws Exception {
        return errorLogDao.createLog(errorLog);
    }
}
