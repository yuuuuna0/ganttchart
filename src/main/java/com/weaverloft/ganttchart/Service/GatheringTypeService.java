package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.GatheringType;

import java.util.List;

public interface GatheringTypeService {
    List<GatheringType> findGathTypeList() throws Exception;
}
