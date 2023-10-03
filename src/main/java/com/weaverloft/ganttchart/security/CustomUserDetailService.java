package com.weaverloft.ganttchart.security;

import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class CustomUserDetailService implements UserDetailsService {

    private UsersDao usersDao;

    public CustomUserDetailService(UsersDao usersDao) {
        this.usersDao = usersDao;
    }

    @Override
    public UserDetails loadUserByUsername(String uId) throws UsernameNotFoundException {
        Users users = usersDao.getUserById(uId);
        return users == null ? null : new CustomUser(users);
    }
}
