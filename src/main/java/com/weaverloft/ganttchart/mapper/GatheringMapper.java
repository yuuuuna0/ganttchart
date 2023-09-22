package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Gathering;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface GatheringMapper {
    List<Gathering> findGathList() throws Exception;

    Gathering findGathByNo(int gathNo) throws Exception;

    int createGath(Gathering gathering) throws Exception;

    int findCurNo() throws Exception;

    int updateGath(Gathering gathering) throws Exception;

    int updateGathStatusNo(Map<String,Object> map) throws Exception;
    int deleteGath(int gathNo) throws Exception;

    int increaseReadCount(int gathNo) throws Exception;

    int changeGathStatusByTime() throws Exception;

    List<Gathering> findTopNGath(int index) throws Exception;

    List<Gathering> findNearGath() throws Exception;

    List<Gathering> findGathByUId(String uId) throws Exception;

    int countGath(String keyword) throws Exception;

    List<Gathering> findGathList2(Map<String, Object> map) throws Exception;
}
