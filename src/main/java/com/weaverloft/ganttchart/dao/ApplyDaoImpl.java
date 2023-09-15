package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.mapper.ApplyMapper;
import org.springframework.stereotype.Repository;

@Repository
public class ApplyDaoImpl implements ApplyDao{
    private ApplyMapper applyMapper;

    public ApplyDaoImpl(ApplyMapper applyMapper) {
        this.applyMapper = applyMapper;
    }
}
