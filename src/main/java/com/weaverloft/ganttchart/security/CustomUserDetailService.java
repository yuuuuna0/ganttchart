package com.weaverloft.ganttchart.security;

import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.mapper.UsersMapper;
import com.weaverloft.ganttchart.security.dto.CustomUsers;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Log4j2
public class CustomUserDetailService implements UserDetailsService {
    @Autowired
    private UsersMapper usersMapper;

    @Override
    public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
        log.warn("Load User by id : "+ id);
        try{
            Users users = usersMapper.findUsersById(id);
            if(users != null){
                //CustomUsers customUsers = new CustomUsers(users);
            }
        } catch (Exception e){
            e.printStackTrace();
}

        return null;
    }
}
