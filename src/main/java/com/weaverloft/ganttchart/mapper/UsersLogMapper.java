package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.UsersLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UsersLogMapper{
    //1. 로그 남기기  ==> 0:가입완료 1:인증완료 / 10:로그인 11:로그아웃
    int createLog(Map<String,Object> map) throws Exception;

    List<UsersLog> findUserLog(Map<String, Object> map);

    int findUsersLogCount();
}
