package com.weaverloft.ganttchart.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface UsersLogMapper{
    //1. 회원가입 로그
    int registerUser(Map<String,Object> map) throws Exception;
    //2. 인증 로그
    int authUser(String id) throws Exception;
    //3. 로그인 로그
    int loginUser(String id) throws Exception;
    //4. 로그아웃 로그
    int logoutUser(String id) throws Exception;
}
