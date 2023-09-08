package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Ufile;
import com.weaverloft.ganttchart.mapper.UfileMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UfileDaoImpl implements UfileDao{
    private UfileMapper ufileMapper;

    public UfileDaoImpl(UfileMapper ufileMapper) {
        this.ufileMapper = ufileMapper;
    }

    @Override
    public int createUfile(Ufile ufile) throws Exception {
        return ufileMapper.createUfile(ufile);
    }

    @Override
    public int updateUfileToNotUse(int ufileNo) throws Exception {
        return ufileMapper.updateUfileToNotUse(ufileNo);
    }

    @Override
    public int deleteUfile(int ufileNo) throws Exception {
        return ufileMapper.deleteUfile(ufileNo);
    }

    @Override
    public List<Ufile> findUfile(String mId, int ufileTypeNo) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("mId",mId);
        map.put("ufileTypeNo",ufileTypeNo);
        return ufileMapper.findUfile(map);
    }
    @Override
    public List<Ufile> findUfile(int no, int ufileTypeNo) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("no",no);
        map.put("ufileTypeNo",ufileTypeNo);
        return ufileMapper.findUfile(map);
    }

    @Override
    public String findUfilePath(int ufileTypeNo) throws Exception {
        return ufileMapper.findUfilePath(ufileTypeNo);
    }

//    @Override
//    public List<Ufile> findUfileListByGathNo(int gathNo) throws Exception {
//        return ufileMapper.findUfileListByGathNo(gathNo);
//    }
//
//    @Override
//    public List<Ufile> findUfileListByReviewNo(int reviewNo) throws Exception {
//        return ufileMapper.findUfileListByReviewNo(reviewNo);
//    }
}
