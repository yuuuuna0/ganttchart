package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Users;

import java.util.List;

public interface UsersService {
    Users findUserById(String id) throws Exception;

    boolean isValidPassword(String uPassword) throws Exception;

    int createUsers(Users users) throws Exception;

    String passwordEncoding(String rawPassword) throws Exception;

    boolean login(String uId, String uPassword, String encodePassword) throws Exception;

    int updateUStatusNo(String uId, int uStatusNo) throws Exception;

    List<String> findIdByNameEmail(String uName, String uEmail) throws Exception;

    int updatePassword(String uId, String tempPassword) throws Exception;

    int updateUser(Users user) throws Exception;

    int withdrawalUser(String uId, int uStatusNo) throws Exception;
}
