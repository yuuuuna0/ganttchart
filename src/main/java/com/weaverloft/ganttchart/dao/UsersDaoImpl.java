package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.mapper.UsersMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UsersDaoImpl implements UsersDao{
    private UsersMapper usersMapper;

    public UsersDaoImpl(UsersMapper usersMapper) {
        this.usersMapper = usersMapper;
    }

    @Override
    public Users findUserById(String id) throws Exception {
        return usersMapper.findUserById(id);
    }

    @Override
    public int createUsers(Users users) throws Exception {
        return usersMapper.createUsers(users);
    }

    @Override
    public Users login(String uId, String uPassword) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("uId",uId);
        map.put("uPassword",uPassword);
        return usersMapper.login(map);
    }

    @Override
    public int updateUStatusNo(String uId, int uStatusNo) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("uId",uId);
        map.put("uStatusNo",uStatusNo);
        return usersMapper.updateUStatusNo(map);
    }

    @Override
    public List<String> findIdByNameEmail(String uName, String uEmail) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("uName",uName);
        map.put("uEmail",uEmail);
        return usersMapper.findIdByNameEmail(map);
    }

    @Override
    public int updatePassword(String uId, String uPassword) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("uId",uId);
        map.put("uPassword",uPassword);
        return usersMapper.updatePassword(map);
    }

    @Override
    public int updateUser(Users user) throws Exception {
        return usersMapper.updateUser(user);
    }

    @Override
    public int updateFileNo(String uId, int fileNo) throws Exception {
        Map<String,Object> map =new HashMap<>();
        map.put("uId",uId);
        map.put("fileNo",fileNo);
        return usersMapper.updateFileNo(map);
    }

    @Override
    public List<Users> findUserList() throws Exception {
        return usersMapper.findUserList();
    }

    @Override
    public int countUser(String keyword) throws Exception {
        return usersMapper.countUser(keyword);
    }

    @Override
    public List<Users> findUserList2(int contentBegin, int contentEnd, String keyword, String filterType, String ascDesc) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("contentBegin",contentBegin);
        map.put("contentEnd",contentEnd);
        map.put("keyword",keyword);
        map.put("filterType",filterType);
        map.put("ascDesc",ascDesc);
        return usersMapper.findUserList2(map);
    }

    @Override
    public Users getUserById(String uId) {
        return usersMapper.getUserById(uId);
    }


}
