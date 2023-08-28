package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.ErrorLogDao;
import com.weaverloft.ganttchart.dto.ErrorLog;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class ErrorLogServiceImpl implements ErrorLogService{
    private ErrorLogDao errorLogDao;

    public ErrorLogServiceImpl(ErrorLogDao errorLogDao) {
        this.errorLogDao = errorLogDao;
    }


    @Override
    public int createLog(ErrorLog errorLog){
//        Users users = (Users)session.getAttribute("loginUser");
//        String id = "";
//        if(users != null) id=users.getId();
//        errorLog.setId(id);
        return errorLogDao.createLog(errorLog);
    }
}
