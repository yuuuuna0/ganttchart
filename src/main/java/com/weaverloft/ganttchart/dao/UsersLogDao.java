package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.UsersLog;
import com.weaverloft.ganttchart.util.PageMakerDto;

import java.util.List;

public interface UsersLogDao {
    //1. 로그 남기기  ==> 0:가입완료 1:인증완료 / 10:로그인 11:로그아웃
    int createLog(String id, int logStatus) throws Exception;

    int findUsersLogCount();

    List<UsersLog> findUsersLogList(int pageBegin, int pageEnd, String keyword);
}
