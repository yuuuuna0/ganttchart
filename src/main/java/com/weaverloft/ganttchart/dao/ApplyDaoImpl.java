package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Apply;
import com.weaverloft.ganttchart.mapper.ApplyMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ApplyDaoImpl implements ApplyDao{
    private ApplyMapper applyMapper;

    public ApplyDaoImpl(ApplyMapper applyMapper) {
        this.applyMapper = applyMapper;
    }

    @Override
    public int createApply(Apply apply) throws Exception {
        return applyMapper.createApply(apply);
    }

    @Override
    public List<Apply> findApplyList() throws Exception {
        return applyMapper.findApplyList();
    }

    @Override
    public List<Apply> findApplyByGathNo(int gathNo) throws Exception {
        return applyMapper.findApplyByGathNo(gathNo);
    }

    @Override
    public List<Apply> findApplyByUId(String uId) throws Exception {
        return applyMapper.findApplyByUId(uId);
    }

    @Override
    public int changeApplyStatusNo(int applyNo, int applyStatusNo) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("applyNo",applyNo);
        map.put("applyStatusNo",applyStatusNo);
        return applyMapper.changeApplyStatusNo(map);
    }

    @Override
    public int countAcceptedApply(int gathNo) throws Exception {
        return applyMapper.countAcceptedApply(gathNo);
    }

    @Override
    public boolean checkDuplication(int gathNo, String uId) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("gathNo",gathNo);
        map.put("uId",uId);
        if(applyMapper.checkDuplication(map)==1){
            return true;
        } else {
            return false;
        }
    }
}
