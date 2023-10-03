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
    // 로그인 후 어디로 이동할 지 해당 핸들러를 커스텀하여 사용
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication auth) throws IOException, ServletException {
        log.info("Login Success");
        List<String> roleNames = new ArrayList<>();
        auth.getAuthorities().forEach(grantedAuthority -> {
            roleNames.add(grantedAuthority.getAuthority());
        });
        log.info("Role Names"+roleNames);

        if(roleNames.contains("ROLE_ADMIN")){
            response.sendRedirect("/admin/menu/register");
            return;
        }
        if(roleNames.contains("ROLE_USER")){
            response.sendRedirect("/board/register");
            return;
        }
        response.sendRedirect("/");

    }
}
