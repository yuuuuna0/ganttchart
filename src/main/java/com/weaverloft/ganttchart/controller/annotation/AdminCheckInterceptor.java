//package com.weaverloft.ganttchart.controller.annotation;
//
//import com.weaverloft.ganttchart.dto.Users;
//import org.springframework.stereotype.Component;
//import org.springframework.web.method.HandlerMethod;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@Component
//public class AdminCheckInterceptor implements HandlerInterceptor {
//    public AdminCheckInterceptor() {
//    }
//
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//
//        // HandlerMethod : @Controller 객체에 @RequestMapping이 붙은 메소드
//        if (!(handler instanceof HandlerMethod)) {
//            return true;
//        }
//
//        HandlerMethod handlerMethod = (HandlerMethod) handler;
//
//        //1. HandlerMethod 객체에 @AdminCheck가 없는 경우, 인증이 필요 없는 요청
//        AdminCheck adminCheck = handlerMethod.getMethodAnnotation(AdminCheck.class);
//        if (adminCheck == null) return true;
//
//        //2. HandlerMethod 객체에 @AdminCheck가 있는 경우
//        //1) 세션에 loginUser 있는지 체크
//        HttpSession session = request.getSession();
//        Users loginUser = (Users) session.getAttribute("loginUser");
//        //2) Referer : HTTP 요청 헤더의 일종으로 요청 보낸 페이지의 URL
//        String requestUrl = request.getHeader("Referer");
//        //3) session으로 요청 보낸 페이지의 url 저장 --> 관리자가 아닐 경우 이전 페이지로 돌려보냄
//        request.getSession().setAttribute("requestUrl", requestUrl);
//        //4) 로그인이 안 되어있으면 로그인 페이지로 이동
//        if (loginUser == null) {
//            session.setAttribute("requestUrl", requestUrl);
//            response.sendRedirect("/user/login");
//            return false;
//        }
//        //5) admin이 아니면(loginUser.getgrade() 가 0 이 아니면)
//        if (loginUser.getAuth() != "ROLE_ADMIN") {
//            if (requestUrl != null) {
//                //요청 URL이 존재할 때, 요청 URL로 돌려보냄
//                session.removeAttribute("requestUrl");
//                response.sendRedirect(requestUrl);
//            } else {
//                //요청 url이 없을 때 메인으로 이동
//                response.sendRedirect("/");
//            }
//            return false;
//        }
//        return true;    // true : controller의 uri로 이동??
//    }
//}
