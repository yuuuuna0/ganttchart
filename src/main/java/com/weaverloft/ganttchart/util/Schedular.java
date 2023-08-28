package com.weaverloft.ganttchart.util;

import com.weaverloft.ganttchart.Service.UsersLogService;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.List;

@Component
public class Schedular {
    private UsersLogService usersLogService;
    private UsersService usersService;

    @Autowired
    public Schedular(UsersLogService usersLogService,UsersService usersService) {
        this.usersLogService = usersLogService;
        this.usersService = usersService;
    }

    //@Transactional : 데이터베이스의 상태를 변경시키는 작업 또는 한번에 수행되어야 하는 연산들 -->propagation: 트랜잭션 있으면 실행, 없으면 새로운 트랜잭션 실행
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class, SQLException.class }, readOnly = false)
    @Scheduled(cron = "0 0 0 * * *")
    public boolean updateEveryday(){
        try {
            System.out.println("1일 스케줄링 테스트");
            List<String> dormacyUsers = usersLogService.findDormacyUsers();
            for(String id : dormacyUsers){
                usersService.updateAuthStatus2(id);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }

}
