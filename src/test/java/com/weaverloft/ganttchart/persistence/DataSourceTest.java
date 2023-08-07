package com.weaverloft.ganttchart.persistence;

import static org.junit.Assert.fail;

import com.weaverloft.ganttchart.config.RootConfig;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import javax.sql.DataSource;
import java.sql.Connection;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/*.xml")
//Java 설정을 하는 경우
//@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class DataSourceTest {

    @Autowired
    private DataSource dataSource;

    @Test
    public void testConnection(){
        try(Connection con = dataSource.getConnection()){
            log.info(con);
        } catch (Exception e){
            fail(e.getMessage());
        }
    }
}
