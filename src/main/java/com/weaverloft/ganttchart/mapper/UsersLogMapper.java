package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.UsersLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface UsersLogMapper{
    //1. 로그 남기기  ==> 0:가입완료 1:인증완료 / 10:로그인 11:로그아웃
    int createLog(Map<String,Object> map) throws Exception;
    //2. 로그 조회하기 (페이징)
    List<UsersLog> findUserLog(Map<String, Object> map) throws Exception;
    int findUsersLogCount(String keyword) throws Exception;
//    //3. 1주일동안 인증완료로 안 바뀐 아이디 찾기 (logStatus가 1주일동안 0->1 안변한)
//    List<String> findUnAuthUsers() throws Exception;
    //4. 60일동안 로그인 안 한 아이디 찾기 (logStatus 10인지 60일이 지난 아이디)
    List<String> findDormacyUsers() throws Exception;
    //5. 오늘의 방문자 수
    int countVisitorsPerDay(Date logDate) throws Exception;
    //5. 오늘의 가입자 수
    int countPersonPerDay(Map<String,Object> map) throws Exception;

}
