package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Controller;
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

    //1. 로그인 페이지
    @GetMapping("/login")
    public String login(HttpServletRequest request){
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
        String forwardPath="";
        int result;

        try{
            result=usersService.createUsers(users);
            if(result == 1){
                //회원가입 성공
                forwardPath="/login";
            }
        } catch (Exception e){
            System.out.println("회원가입 실패");
            forwardPath="/register";
        }
        return forwardPath;
    }

    //3. 내정보 확인 페이지
    @GetMapping("/mypage")
    public String mypage(HttpServletRequest request) throws Exception{
        String forwardPath="";
        HttpSession session = request.getSession();
        Users loginUser=(Users)session.getAttribute("loginUser");
        System.out.println("loginUser >> "+loginUser);
        if(loginUser ==null){
            forwardPath="/login";
        }
        loginUser=usersService.findUsersById(loginUser.getId());
        request.setAttribute("loginUser",loginUser);
        System.out.println(loginUser);
        forwardPath="/mypage";
        return forwardPath;
    }

}
