package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;

import java.util.List;

public interface UsersDao {
    Users findUserById(String id) throws Exception;

    int createUsers(Users users) throws Exception;

    Users login(String uId, String uPassword) throws Exception;

    int updateUStatusNo(String uId, int uStatusNo) throws Exception;

    List<String> findIdByNameEmail(String uName, String uEmail) throws Exception;

    int updatePassword(String uId, String encodePassword) throws Exception;

    int updateUser(Users user) throws Exception;

    int updateFileNo(String uId, int fileNo) throws Exception;

    List<Users> findUserList() throws Exception;

    int countUser(String keyword) throws Exception;

    List<Users> findUserList2(int contentBegin, int contentEnd, String keyword, String filterType, String ascDesc) throws Exception;

    Users getUserById(String uId);
}
