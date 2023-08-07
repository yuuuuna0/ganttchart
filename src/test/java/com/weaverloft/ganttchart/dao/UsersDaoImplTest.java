package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.config.ApplicationConfig;
import com.weaverloft.ganttchart.config.ServletConfig;
import com.weaverloft.ganttchart.dto.Users;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.Date;


@RunWith(SpringRunner.class)        //단위테스트를 스프링과 연동
@WebAppConfiguration
@ContextConfiguration(classes = {ApplicationConfig.class, ServletConfig.class})    //환경설정 파일 명시
public class UsersDaoImplTest {

    @Autowired
    private UsersDao usersDao;

    @Test
    public void init(){
        System.out.println(usersDao);
    }

    @Test
    public void createUsers() throws Exception{
        Users newUsers = new Users("test3",1,"test3!","test3","default.jpg",new Date(),0,"010-5555-5555","서울시 구로구","test3@naver.com");
        int result;
        result=usersDao.createUsers(newUsers);
        System.out.println(result);
    }

    @Test
    public void findUsersById() throws Exception{
        Users findUsers=usersDao.findUsersById("admin");
        System.out.println(findUsers);
    }

    @Test
    public void updateUsers() {
    }

    @Test
    public void deleteUsers() throws Exception{
        int result;
        System.out.println(usersDao.deleteUsers("test3"));
    }
}
