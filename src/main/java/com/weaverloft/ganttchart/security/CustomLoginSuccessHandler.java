package com.weaverloft.ganttchart.security;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j2
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    //로그인 성공시 admin인지 member인지에 따라 설정 해주는 핸들러
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        log.warn("login success");

        List<String> roleNames = new ArrayList<String>();

        authentication.getAuthorities().forEach(authority -> {
            roleNames.add(authority.getAuthority());
        });
        log.warn("ROLE NAMES : "+roleNames);

        if(roleNames.contains("ROLE_ADMIN")){
            response.sendRedirect("/sample/admin");
            return;
        }
        if(roleNames.contains("ROLE_MEMBER")){
            response.sendRedirect("/sample/member");
            return;
        }
        response.sendRedirect("/");
    }
}
