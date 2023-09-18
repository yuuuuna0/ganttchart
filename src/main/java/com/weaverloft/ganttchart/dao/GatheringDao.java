package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Gathering;
import org.springframework.web.servlet.tags.EscapeBodyTag;

import java.util.List;
import java.util.Map;

public interface GatheringDao {
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
