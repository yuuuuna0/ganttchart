package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.EmailService;
import com.weaverloft.ganttchart.Service.SHA256Service;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.exception.ExistedUserException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

@Controller
public class UsersController {
    private UsersService usersService;
    private SHA256Service sha256Service;
    private EmailService emailService;

    public UsersController(UsersService usersService,SHA256Service sha256Service,EmailService emailService) {
        this.usersService = usersService;
        this.sha256Service = sha256Service;
        this.emailService = emailService;
    }
    //1. 회원가입 페이지
    @GetMapping("/register")
    public String register(){
        return "register";
    }

    //2. 회원가입 액션
    @PostMapping("register-action")
    public ModelAndView registerAction(@RequestParam Map map) throws Exception{
        ModelAndView mv=new ModelAndView();
        String id=(String)map.get("id");
        String password=(String)map.get("password");
        String name=(String)map.get("name");
        String email=(String)map.get("email");
        String phone=(String)map.get("phone");
        String address=(String)map.get("address");
        String photo=(String)map.get("photo");
        int gender=0;       //Integer.parseInt((String)map.get("gender"));
        try {
            //1) 아이디 중복 확인
            if (usersService.isExistedId(id)) {
                mv.setViewName("login");
                throw new ExistedUserException("이미 존재하는 아이디입니다.");
            }
                /*
                //2) 비밀번호 정규식 체크
                if(!usersService.isValidPassword(password)){
                    mv.setViewName("login");
                    throw new isInvalidPasswordException("비밀번호는 영문,숫자,특수문자를 포함한 8글자 이상 15글자 이하여야합니다.");
                }
                */
            //3) 비밀번호 암호화
            String encryptPassword = sha256Service.encrypt(password);

            Users newUsers = new Users(id, 0, encryptPassword, name, "", new Date(), gender, phone, address, email, 0, "0");
            System.out.println(newUsers);

            //4) 인증메일 보내기
            //-1. DB에 기본 정보 insert
            int result=usersService.createUsers(newUsers);
            System.out.println(result);
            //-2. 임의의 authKey 생성 & 이메일 발송
            String authKey = emailService.sendMail(newUsers.getEmail())+"";
            newUsers.setAuthKey(authKey);

            //5) 파일 업로드
            if (photo != null) {
                System.out.println("사진 있다");
                newUsers.setPhoto(photo);
            }

            //메일키, 사진 업데이트 DB에 반영
            System.out.println(newUsers);
            usersService.updateUsers(newUsers);
        } catch (Exception e){
            e.getMessage();
            e.printStackTrace();;
        }
        mv.setViewName("login");
        return mv;
    }
    //3. 로그인 페이지
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    //4. 로그인 액션
    @PostMapping("/login-action")
    public String loginAction(HttpServletRequest request,
                              @RequestParam Map map) throws Exception{
        HttpSession session=request.getSession();
        String id=(String)map.get("id");
        String password=(String)map.get("password");
        String forwardPath="";
        try{
            Users loginUser=usersService.login(id,password);
            System.out.println("loginUser 정보 : "+loginUser);
            System.out.println("authStatus: "+loginUser.getAuthStatus());
            session.setAttribute("loginUser", loginUser);
            if(loginUser.getAuthStatus()==0){
                //첫번째 로그인 -> 이메일 인증 필요!
                forwardPath="redirect:emailAuth";
            } else if(loginUser.getAuthStatus()==1) {
                //인증된 사용자
                System.out.println("로그인 성공");
                forwardPath = "redirect:index";
            }
        } catch (Exception e){
            e.printStackTrace();
            System.out.println("로그인 실패");
            forwardPath="redirect:login";
        }
        return forwardPath;
    }


    //4. 이메일 인증 페이지

    @GetMapping("emailAuth")
    public String emailAuth(){
        return "emailAuth";
    }
    //5. 이메일 인증 액션

    @PostMapping("emailAuth-action")
    public ModelAndView emailAuthAction(HttpSession session,@RequestParam Map map){
        ModelAndView mv=new ModelAndView();
        String authKey=(String)map.get("authKey");
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            if(authKey.equals(loginUser.getAuthKey())){
                usersService.updateAuthStatus(loginUser.getId(),1);
            } else{
                System.out.println("인증번호가 다릅니다");   //인증이 안됨,,,,
                mv.setViewName("emailAuth");
            }
            session.setAttribute("loginUser",loginUser);
            mv.setViewName("index");
        }catch (Exception e){
            e.printStackTrace();
        }
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
    //5. 로그아웃 액션
    @GetMapping("/logout-action")
    public String logoutAction(HttpServletRequest request){
        request.getSession(false).invalidate();
        return "index";
    }
}
