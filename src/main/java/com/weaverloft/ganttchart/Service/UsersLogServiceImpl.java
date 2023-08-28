package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.UsersLogDao;
import com.weaverloft.ganttchart.dto.UsersLog;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UsersLogServiceImpl implements UsersLogService{
    private UsersLogDao usersLogDao;

    public UsersLogServiceImpl(UsersLogDao usersLogDao) {
        this.usersLogDao = usersLogDao;
    }

    @Override
    public int createLog(String id, int logStatus) throws Exception{
        return usersLogDao.createLog(id,logStatus);
    }

    @Override
    public PageMakerDto findUserLog(int pageNo, String keyword) {
        int totUsersLogCount = usersLogDao.findUsersLogCount();
        PageMaker pageMaker = new PageMaker(totUsersLogCount,pageNo);
        List<UsersLog> usersLogList = usersLogDao.findUsersLogList(pageMaker.getPageBegin(),pageMaker.getPageEnd(),keyword);
        PageMakerDto<UsersLog> pageMakerUsersLogList = new PageMakerDto<>(usersLogList,pageMaker,totUsersLogCount);
        return pageMakerUsersLogList;
    }

    @Override
    public List<String> findDormacyUsers() throws Exception {
        return usersLogDao.findDormacyUsers();
    }
}
