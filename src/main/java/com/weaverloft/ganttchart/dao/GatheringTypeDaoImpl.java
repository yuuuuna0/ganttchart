package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.GatheringType;
import com.weaverloft.ganttchart.mapper.GatheringTypeMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GatheringTypeDaoImpl implements GatheringTypeDao{
    private GatheringTypeMapper gatheringTypeMapper;

    public GatheringTypeDaoImpl(GatheringTypeMapper gatheringTypeMapper) {
        this.gatheringTypeMapper = gatheringTypeMapper;
    }

    @Override
    public List<GatheringType> findGathTypeList() throws Exception {
        return gatheringTypeMapper.findGathTypeList();
    }

    @Override
    public GatheringType findGathTypeByNo(int gathTypeNo) throws Exception {
        return gatheringTypeMapper.findGathTypeByNo(gathTypeNo);
    }
}
