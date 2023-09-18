package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Gathering;

import java.util.List;

public interface GatheringService {
    List<Gathering> findGathList() throws Exception;

    Gathering findGathByNo(int gathNo) throws Exception;

    int createGath(Gathering gathering) throws Exception;

    int findCurNo() throws Exception;

    int updateGath(Gathering gathering) throws Exception;

    int updateGathStatusNo(int gathNo, int gathStatusNo) throws Exception;

    int deleteGath(int gathNo) throws Exception;

    int increaseReadCount(int gathNo) throws Exception;

    int changeGathStatusByTime() throws Exception;
}
