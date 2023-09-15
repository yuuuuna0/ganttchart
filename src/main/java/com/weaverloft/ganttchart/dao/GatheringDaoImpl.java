package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Gathering;
import com.weaverloft.ganttchart.mapper.GatheringMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class GatheringDaoImpl implements GatheringDao {
    private GatheringMapper gatheringMapper;

    public GatheringDaoImpl(GatheringMapper gatheringMapper) {
        this.gatheringMapper = gatheringMapper;
    }

    @Override
    public List<Gathering> findGathList() throws Exception {
        return gatheringMapper.findGathList();
    }

    @Override
    public Gathering findGathByNo(int gathNo) throws Exception {
        return gatheringMapper.findGathByNo(gathNo);
    }

    @Override
    public int createGath(Gathering gathering) throws Exception {
        return gatheringMapper.createGath(gathering);
    }

    @Override
    public int findCurNo() throws Exception {
        return gatheringMapper.findCurNo();
    }

    @Override
    public int updateGath(Gathering gathering) throws Exception {
        return gatheringMapper.updateGath(gathering);
    }

    @Override
    public int updateGathStatusNo(int gathNo, int gathStatusNo) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("gathNo",gathNo);
        map.put("gathStatusNo",gathStatusNo);
        return gatheringMapper.updateGathStatusNo(map);
    }

    @Override
    public int deleteGath(int gathNo) throws Exception {
        return gatheringMapper.deleteGath(gathNo);
    }

    @Override
    public int increaseReadCount(int gathNo) throws Exception {
        return gatheringMapper.increaseReadCount(gathNo);
    }
}
