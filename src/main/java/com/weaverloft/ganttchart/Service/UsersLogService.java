package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.util.PageMakerDto;

import java.util.Date;
import java.util.List;

public interface UsersLogService {
    //1. 로그 남기기  ==> 0:가입완료 1:인증완료 / 10:로그인 11:로그아웃
    int createLog(String id, int logStatus) throws Exception;
    //2. 로그 전체 조회 --> 페이징
    PageMakerDto findUserLog(int pageNo, String keyword) throws Exception;
    //4. 60일동안 로그인 안 한 아이디 찾기 (logStatus 10인지 60일이 지난 아이디)
    List<String> findDormacyUsers() throws Exception;
    //5. 오늘의 방문자 수
    int countVisitorsPerDay(Date logDate) throws Exception;
}
