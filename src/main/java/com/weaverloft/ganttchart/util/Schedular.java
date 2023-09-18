package com.weaverloft.ganttchart.util;

import com.weaverloft.ganttchart.Service.GatheringService;
import com.weaverloft.ganttchart.dto.Gathering;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.List;

@Component
public class Schedular {
    private GatheringService gatheringService;

    @Autowired
    public Schedular(GatheringService gatheringService) {
        this.gatheringService = gatheringService;
    }

    //@Transactional : 데이터베이스의 상태를 변경시키는 작업 또는 한번에 수행되어야 하는 연산들 -->propagation: 트랜잭션 있으면 실행, 없으면 새로운 트랜잭션 실행
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class, SQLException.class }, readOnly = false)
    @Scheduled(cron = "0 0 0 * * *")
    public boolean updateEveryday(){
        try{
            System.out.println("1일 스케줄링 테스트");
            //1. 날짜 지난 모임 모임완료(3)로 상태 변경하기
            int result = gatheringService.changeGathStatusByTime();
            //2.
        } catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }
}
