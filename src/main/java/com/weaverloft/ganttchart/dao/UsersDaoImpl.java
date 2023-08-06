package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Repository;

@Repository
public class UsersDaoImpl implements UsersDao {
    @Override
    public int createUsers(Users users) throws Exception {
        return 0;
    }

    @Override
    public Users findUsersById(String id) throws Exception {
        return null;
    }

    @Override
    public Users updateUsers(Users users) throws Exception {
        return null;
    }

    @Override
    public int deleteUsers(String id) throws Exception {
        return 0;
    }
}
