package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.GatheringType;

import java.util.List;

public interface GatheringTypeDao {
    List<GatheringType> findGathTypeList() throws Exception;

    GatheringType findGathTypeByNo(int gathTypeNo) throws Exception;
}
