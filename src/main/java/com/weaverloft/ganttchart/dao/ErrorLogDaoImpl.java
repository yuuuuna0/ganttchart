package com.weaverloft.ganttchart.dao;


import com.weaverloft.ganttchart.dto.ErrorLog;
import com.weaverloft.ganttchart.mapper.ErrorLogMapper;
import org.springframework.stereotype.Repository;

@Repository
public class ErrorLogDaoImpl implements ErrorLogDao {
    private ErrorLogMapper errorLogMapper;

    public ErrorLogDaoImpl(ErrorLogMapper errorLogMapper) {
        this.errorLogMapper = errorLogMapper;
    }

    @Override
    public int createLog(ErrorLog errorLog)  {
        return errorLogMapper.createLog(errorLog);
    }
}
