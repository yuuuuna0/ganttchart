package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.UsersLogDao;
import org.springframework.stereotype.Service;

@Service
public class UsersLogServiceImpl implements UsersLogService{
    private UsersLogDao usersLogDao;

    public UsersLogServiceImpl(UsersLogDao usersLogDao) {
        this.usersLogDao = usersLogDao;
    }

    @Override
    public int registerUser(String id) throws Exception{
        return usersLogDao.registerUser(id);
    }

    @Override
    public int authUser(String id) throws Exception{
        return usersLogDao.authUser(id);
    }

    @Override
    public int loginUser(String id) throws Exception{
        return usersLogDao.loginUser(id);
    }

    @Override
    public int logoutUser(String id) throws Exception{
        return usersLogDao.logoutUser(id);
    }
}
