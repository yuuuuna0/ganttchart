package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.GatheringType;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface GatheringTypeMapper {
    List<GatheringType> findGathTypeList() throws Exception;

    GatheringType findGathTypeByNo(int gathTypeNo) throws Exception;
}
