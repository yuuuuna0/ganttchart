package com.weaverloft.ganttchart.persistence;

import com.weaverloft.ganttchart.mapper.TimeMapper;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.weaverloft.ganttchart.config.ApplicationConfig.class})
@Log4j
public class TimeMapperTest {
    @Autowired
    private TimeMapper timeMapper;

    @Test
    public void testGetTime1(){
        log.info(timeMapper.getClass().getName());
        log.info(timeMapper.getTime1());
    }
    @Test
    public void testGetTime2(){
        log.info("getTime2");
        log.info(timeMapper.getTime2());
    }
}
