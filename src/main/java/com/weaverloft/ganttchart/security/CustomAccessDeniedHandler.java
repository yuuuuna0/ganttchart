package com.weaverloft.ganttchart.security;

import lombok.extern.log4j.Log4j2;
import org.springframework.context.annotation.Bean;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j2
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    //권한 외의 페이지에 접근 할 경우 accessError 페이지를 띄워준다.
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException e) throws IOException, ServletException {
        log.error("Access Denied Handler");
        log.error("Redirect ,,,");
        response.sendRedirect("/accessError");
    }
}
