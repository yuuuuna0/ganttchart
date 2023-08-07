package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class UsersController {
    private UsersService usersService;
    public UsersController(UsersService usersService) {
        this.usersService=usersService;
    }

    @GetMapping("/login")
    //1. 로그인 페이지
    public String login(HttpServletRequest request, Model model){
        HttpSession session=request.getSession();

        String prevPage = request.getHeader("Referer");
        if(prevPage ==null || prevPage.contains("/login")){
            prevPage = request.getContextPath() +"/index";
        }
        session.setAttribute("prevPage",prevPage);
        model.addAttribute("prevPage",prevPage);
        return "login";
    }
    //2. 로그인 액션
    @PostMapping("/login-action")
    public String loginAction(HttpServletRequest request,
                              HttpServletResponse response,
                              @ModelAttribute Users users) throws Exception{
        HttpSession session=request.getSession();
        String forwardPath="";
        try{
            Users loginUser=usersService.login(users.getId(),users.getPassword());
            session.setAttribute("loginUser", loginUser);
            forwardPath="/dashboard";
        } catch (Exception e){
            e.printStackTrace();
            forwardPath="/login";
        }
        return forwardPath;
    }

    //2. 회원가입 페이지
    @GetMapping("/register")
    public String register(){
        return "register";
    }

    //3. 회원가입 액션
    @PostMapping("/register-action")
    public String registerAction(@ModelAttribute Users users) throws Exception{

        int result;
        result=usersService.createUsers(users);
        if(result == 1){
            //회원가입 성공
        }
        return "login";
    }

    //3. 내정보 확인 페이지
    @GetMapping("/mypage")
    public String mypage(){
        return "mypage";
    }
}
