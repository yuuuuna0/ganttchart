package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.SHA256Service;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.exception.ExistedUserException;
import com.weaverloft.ganttchart.exception.isInvalidPasswordException;
import lombok.RequiredArgsConstructor;
import oracle.jdbc.proxy.annotation.Post;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UsersController {
    private UsersService usersService;
    private SHA256Service sha256Service;

    public UsersController(UsersService usersService,SHA256Service sha256Service) {
        this.usersService = usersService;
        this.sha256Service = sha256Service;
    }

    //1. 로그인 페이지
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    //2. 로그인 액션
    @PostMapping("/login-action")
    public String loginAction(HttpServletRequest request,
                              @Param("id")String id, @Param("password")String password) throws Exception{
        HttpSession session=request.getSession();
        String forwardPath="";
        try{
            Users loginUser=usersService.login(id,password);
            session.setAttribute("loginUser",loginUser);
            System.out.println("로그인 성공");
            forwardPath="index";
        } catch (Exception e){
            e.printStackTrace();
            System.out.println("로그인 실패");
            forwardPath="redirect:login";
        }
        return forwardPath;
    }
    //3. 로그아웃 액션
    @PostMapping("/logout-action")
    public String logoutAction(HttpServletRequest request){
        request.getSession(false).invalidate();
        return "index";
    }

    //2. 회원가입 페이지
    @GetMapping("/register")
    public String register(){

        return "register";
    }

    //3. 회원가입 액션
    @PostMapping("register-action")
    public ModelAndView registerAction(Map<String,Object> map) throws Exception{
        ModelAndView mv=new ModelAndView();
        String id=(String)map.get("id");
        String password=(String)map.get("password");
        //1) 아이디 중복 확인
        if(usersService.isExistedId(id)){
            mv.setViewName("login");
            throw new ExistedUserException("이미 존재하는 아이디입니다.");
        }
        //2) 비밀번호 정규식 체크
        if(!usersService.isValidPassword(password)){
            mv.setViewName("login");
            throw new isInvalidPasswordException("비밀번호는 영문,숫자,특수문자를 포함한 8글자 이상 15글자 이하여야합니다.");
        }
        //3) 비밀번호 암호화
        String encryptPassword = sha256Service.encrypt(password);
        //4) 메일 인증




/*
            Map에 담긴 String 타입의 birth Date 타입으로 변경
            String birthStr=(String)map.get("birth");
            SimpleDateFormat birthFormat=new SimpleDateFormat("yyyy-MM-dd");
            Date birth=birthFormat.parse(birthStr);
            System.out.println(birth.getClass().getName());


            //회원 사진 업로드
*/
        return mv;
    }
/*
    //3. 파일 업로드


    //3. 비밀번호 찾기 페이지
    @GetMapping("/findPassword")
    public String findPassword(HttpServletRequest request)  throws Exception{
        return "/findPassword";
    }
    //3. 아이디 찾기 페이지
    @GetMapping("/findId")
    public String findId(HttpServletRequest request)  throws Exception{
        return "/findId";
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
*/
}
