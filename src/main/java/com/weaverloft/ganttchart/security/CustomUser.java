package com.weaverloft.ganttchart.security;

import com.weaverloft.ganttchart.dto.Users;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

@Setter
public class CustomUser  extends User {
    private Users users;
    public CustomUser(String username, String password, boolean enabled, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }
}
