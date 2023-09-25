package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Gathering;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.SearchDto;

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

    List<Gathering> findTopNGath(int index) throws Exception;

    List<Gathering> findNearGath() throws Exception;

    List<Gathering> findGathByUId(String uId) throws Exception;

    SearchDto<Gathering> findSearchedGathList(int pageNo, String keyword, String filterType, String ascDesc, int cityNo, int gathTypeNo, int gathStatusNo) throws Exception;
}
