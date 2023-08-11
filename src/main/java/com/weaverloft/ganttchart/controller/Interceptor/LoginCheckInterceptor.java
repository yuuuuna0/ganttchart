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

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception {

        //HandlerMethod: @Controller 객체에 @RequestMapping이 붙은 메소드
        if (handler instanceof HandlerMethod == false) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;

        //HandlerMethod 객체에 @Logincheck가 없는 경우 인증이 필요 없는 요청
        LoginCheck loginCheck = handlerMethod.getMethodAnnotation(LoginCheck.class);
        if (loginCheck == null) {
            return true;
        }

        //HandlerMethod객체에 LoginCheck가 있는 경우 session이 있는지 체크
        HttpSession session = request.getSession();
        Users loginUsers=(Users) session.getAttribute("loginUsers");

        //Referer: HTTP 요청 헤더의 일종으로, 요청 보낸 페이지의 url 의미
        String requestUrl=request.getHeader("Referer");

        //session에 요청 보낸 페이지 url 저장 ----> 관리자 아닐 경우 이전 페이지로 돌려보내기 위함
        request.getSession().setAttribute("requestUrl",requestUrl);

        //로그인이 안되어있는 상태 --> 로그인 페이지로 돌려보냄
        if(loginUsers ==null){
            session.setAttribute("requestUrl",requestUrl);
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }

}

