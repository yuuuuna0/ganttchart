package com.weaverloft.ganttchart.dao;

public interface UsersLogDao {
    //1. 회원가입 로그
    int registerUser(String id) throws Exception;
    //2. 인증 로그
    int authUser(String id) throws Exception;
    //3. 로그인 로그
    int loginUser(String id) throws Exception;
    //4. 로그아웃 로그
    int logoutUser(String id) throws Exception;
}
