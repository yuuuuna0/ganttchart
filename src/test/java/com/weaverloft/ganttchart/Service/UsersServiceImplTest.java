package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.config.ApplicationConfig;
import com.weaverloft.ganttchart.config.ServletConfig;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;


@RunWith(SpringRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {ApplicationConfig.class, ServletConfig.class})
public class UsersServiceImplTest {
    @Autowired
    private UsersService usersService;

    @Test
    public void createUsers() {
    }

    @Test
    public void isValidPassword() {
    }

    @Test
    public void findUsersById() {
    }

    @Test
    public void updateUsers() {
    }

    @Test
    public void deleteUsers() {
    }

    @Test
    public void updatePassword() {
    }

    @Test
    public void login() {
    }

    @Test
    public void findUsersByIdEmail() {
    }
}
