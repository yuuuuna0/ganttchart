package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.ApplyDao;
import org.springframework.stereotype.Service;

@Service
public class ApplyServiceImpl implements ApplyService{
    private ApplyDao applyDao;

    public ApplyServiceImpl(ApplyDao applyDao) {
        this.applyDao = applyDao;
    }
}
