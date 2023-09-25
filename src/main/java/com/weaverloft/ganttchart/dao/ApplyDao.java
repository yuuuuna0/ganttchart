package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Apply;

import java.util.List;
import java.util.Map;

public interface ApplyDao {
    int createApply(Apply apply) throws Exception;

    List<Apply> findApplyList() throws Exception;

    List<Apply> findApplyByGathNo(int gathNo) throws Exception;

    List<Apply> findApplyByUId(String uId) throws Exception;

    int changeApplyStatusNo(int applyNo, int applyStatusNo) throws Exception;

    int countAcceptedApply(int gathNo) throws Exception;

    boolean checkDuplication(int gathNo, String uId) throws Exception;
}
