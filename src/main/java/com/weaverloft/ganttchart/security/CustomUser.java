package com.weaverloft.ganttchart.security;

import com.weaverloft.ganttchart.dto.Users;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.stream.Collectors;

@Setter
@Getter
public class CustomUser  extends User {
    private Users users;
    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }
    public CustomUser(Users users){
        super(users.getUId(),users.getUPassword(),
                users.getAuthList().stream().map(authorities -> new SimpleGrantedAuthority(authorities.getAuthority())).collect(Collectors.toList()));
        this.users = users;

    }
}
