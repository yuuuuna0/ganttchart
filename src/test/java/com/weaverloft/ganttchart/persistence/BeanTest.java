package com.weaverloft.ganttchart.persistence;

import com.weaverloft.ganttchart.config.ApplicationConfig;
import com.weaverloft.ganttchart.dao.UsersDaoImplTest;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringRunner.class)        //단위테스트를 스프링과 연동
@ContextConfiguration(classes = ApplicationConfig.class)    //환경설정 파일 명시
public class BeanTest {
    private static final Logger logger = LoggerFactory.getLogger(UsersDaoImplTest.class);

    @Autowired
    DataSource ds;

   // @Autowired
    //SqlSessionTemplate st;

    @Test
    public void dsTest(){
        //DataSource가 null이 아니다!
        assertNotNull(ds);
    }

    @Test
    public void templateTest() {
        //SqlSessionTemplate가 null이 아니다!
        //
        // assertNotNull(st);
    }
}
