package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.GatheringTypeDao;
import com.weaverloft.ganttchart.dto.GatheringType;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GatheringTypeServiceImpl implements GatheringTypeService{
    private GatheringTypeDao gatheringTypeDao;

    public GatheringTypeServiceImpl(GatheringTypeDao gatheringTypeDao) {
        this.gatheringTypeDao = gatheringTypeDao;
    }

    @Override
    public List<GatheringType> findGathTypeList() throws Exception {
        return gatheringTypeDao.findGathTypeList();
    }
}
