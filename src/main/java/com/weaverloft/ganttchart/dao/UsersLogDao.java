package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.UsersLog;
import com.weaverloft.ganttchart.util.PageMakerDto;

import java.util.Date;
import java.util.List;

public interface UsersLogDao {
    //1. 로그 남기기  ==> 0:가입완료 1:인증완료 / 10:로그인 11:로그아웃
    int createLog(String id, int logStatus) throws Exception;

    int findUsersLogCount(String keyword) throws Exception;
    //3. 1주일동안 인증완료로 안 바뀐 아이디 찾기 (logStatus가 1주일동안 0->1 안변한)
    List<UsersLog> findUsersLogList(int pageBegin, int pageEnd, String keyword) throws Exception;
    //4. 60일동안 로그인 안 한 아이디 찾기 (logStatus 10인지 60일이 지난 아이디)
    List<String> findDormacyUsers() throws Exception;
    //5. 오늘의 방문자 수
    int countPersonPerDay(int logStatus,Date logDate) throws Exception;
}
