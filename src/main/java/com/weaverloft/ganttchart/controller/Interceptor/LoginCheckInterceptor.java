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
public class LoginCheckInterceptor implements HandlerInterceptor {
    public LoginCheckInterceptor() {
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


        HandlerMethod handlerMethod = (HandlerMethod) handler;

        //1. HandlerMethod 객체에 @LoginCheck가 없는 경우, 인증이 필요 없는 요청
        LoginCheck loginCheck = handlerMethod.getMethodAnnotation(LoginCheck.class);
        if (loginCheck == null) return true;

            //2. HandlerMethod 객체에 @LoginCheck가 있는 경우
            //1) 세션에 loginUser 있는지 체크
            HttpSession session = request.getSession();
            Users loginUser = (Users) session.getAttribute("loginUser");
            //2) Referer : HTTP 요청 헤더의 일종으로 요청 보낸 페이지의 URL
            String requestUrl = request.getHeader("Referer");
            //3) session으로 요청 보낸 페이지의 url 저장 --> 관리자가 아닐 경우 이전 페이지로 돌려보냄
            request.getSession().setAttribute("requestUrl", requestUrl);
            //4) 로그인이 안 되어있으면 로그인 폼으로 돌려보냄
            if (loginUser == null) {
                session.setAttribute("requestUrl", requestUrl);
                response.sendRedirect("/login");
                return false;
            }

            return true;
        }

    }