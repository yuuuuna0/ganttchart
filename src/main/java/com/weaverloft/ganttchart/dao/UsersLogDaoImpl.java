package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.UsersLog;
import com.weaverloft.ganttchart.mapper.UsersLogMapper;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UsersLogDaoImpl implements UsersLogDao{
    private UsersLogMapper usersLogMapper;

    public UsersLogDaoImpl(UsersLogMapper usersLogMapper) {
        this.usersLogMapper = usersLogMapper;
    }

    @Override
    public int createLog(String id, int logStatus) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        map.put("logStatus",logStatus);
        return usersLogMapper.createLog(map);
    }

    @Override
    public List<UsersLog> findUsersLogList(int pageBegin, int pageEnd, String keyword) {
        Map<String,Object> map = new HashMap<>();
        map.put("pageBegin",pageBegin);
        map.put("pageEnd",pageEnd);
        map.put("keyword",keyword);
        return usersLogMapper.findUserLog(map);
    }

    @Override
    public int findUsersLogCount() {
        return usersLogMapper.findUsersLogCount();
    }

}
