package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.mapper.UsersLogMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class UsersLogDaoImpl implements UsersLogDao{
    private UsersLogMapper usersLogMapper;

    public UsersLogDaoImpl(UsersLogMapper usersLogMapper) {
        this.usersLogMapper = usersLogMapper;
    }

    @Override
    public int registerUser(String id) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        return usersLogMapper.registerUser(map);
    }

    @Override
    public int authUser(String id) throws Exception{
        return usersLogMapper.authUser(id);
    }

    @Override
    public int loginUser(String id) throws Exception{
        return usersLogMapper.loginUser(id);
    }

    @Override
    public int logoutUser(String id) throws Exception{
        return usersLogMapper.logoutUser(id);
    }
}
