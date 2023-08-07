package com.weaverloft.ganttchart.controller.Interceptor;

import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
@RequiredArgsConstructor
public class LoginCheckInterceptor implements HandlerInterceptor {
    private UsersService usersService;

    public LoginCheckInterceptor(UsersService usersService) {
        this.usersService=usersService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception {
        if (handler instanceof HandlerMethod == false) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;

        LoginCheck loginCheck = handlerMethod.getMethodAnnotation(LoginCheck.class);
        if (loginCheck == null) {
            return true;
        }

        HttpSession session = request.getSession();
        Users loginUsers=(Users) session.getAttribute("loginUsers");
        String requestUrl=request.getHeader("Referer");
        request.getSession().setAttribute("requestUrl",requestUrl);

        if(loginUsers ==null){
            session.setAttribute("requestUrl",requestUrl);
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }

}

