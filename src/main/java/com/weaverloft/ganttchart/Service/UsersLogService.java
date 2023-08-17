package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.util.PageMakerDto;

public interface UsersLogService {
    //1. 로그 남기기  ==> 0:가입완료 1:인증완료 / 10:로그인 11:로그아웃
    int createLog(String id, int logStatus) throws Exception;
    //2. 로그 전체 조회 --> 페이징
    PageMakerDto findUserLog(int pageNo, String keyword);
}
