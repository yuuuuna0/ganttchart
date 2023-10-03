package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Users;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UsersMapper {
    Users findUserById(String id) throws Exception;

    int createUsers(Users users) throws Exception;

    Users login(Map<String, Object> map) throws Exception;

    int updateUStatusNo(Map<String, Object> map) throws Exception;

    List<String> findIdByNameEmail(Map<String, Object> map) throws Exception;

    int updatePassword(Map<String, Object> map) throws Exception;

    int updateUser(Users user) throws Exception;

    int updateFileNo(Map<String,Object> map) throws Exception;

    List<Users> findUserList() throws Exception;

    int countUser(String keyword) throws Exception;

    List<Users> findUserList2(Map<String, Object> map) throws Exception;

    Users getUserById(String uId);
}
