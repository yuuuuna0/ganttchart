package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.EmailService;
import com.weaverloft.ganttchart.Service.SHA256Service;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.exception.ExistedUserException;
import com.weaverloft.ganttchart.exception.isInvalidPasswordException;
import org.apache.ibatis.annotations.Param;
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
    //1-1. 회원가입 페이지
    @GetMapping("/register")
    public String register(){
        return "register";
    }
    //1-2. 회원가입 액션
    @PostMapping("register-action")
    public ModelAndView registerAction(@RequestParam Map map, ModelAndView mv) throws Exception{
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
            if (usersService.findUsersById(id)!=null) {
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
            //4) 인증메일 보내기 -> 임의의 authKey 생성 & 이메일 발송
            int authKey = emailService.sendAuthEmail(email);
            String authKeyStr=Integer.toString(authKey);
            //5) 파일 업로드
            if (photo != null) {
                System.out.println("사진 있다");
               // newUsers.setPhoto(photo);
            }
            Users newUsers = new Users(id, 0, encryptPassword, name, "", new Date(), gender, phone, address, email, 0, authKeyStr);
            int result=usersService.createUsers(newUsers);


            //메일키, 사진, 암호화된 비번 업데이트 DB에 반영
            System.out.println(newUsers);
            //usersService.updateUsers(newUsers);
            System.out.println(usersService.findUsersById(newUsers.getId()));   //인증번호 왜사라짐???? 왜??
        } catch (Exception e){
            e.getMessage();
            e.printStackTrace();;
        }
        mv.setViewName("login");
        return mv;
    }

    //2-1. 로그인 페이지
    @GetMapping("/login")
    public String login(){
        return "login";
    }
    //2-2. 로그인 액션
    @PostMapping("/login-action")
    public String loginAction(HttpServletRequest request,
                              @RequestParam Map map) throws Exception{
        HttpSession session=request.getSession();
        String id=(String)map.get("id");
        String password=(String)map.get("password");
        String forwardPath="";
        try{
            Users loginUser=usersService.login(id,sha256Service.encrypt(password));
            System.out.println(loginUser);
            session.setAttribute("loginUser", loginUser);
            if(loginUser.getAuthStatus()==0){
                //미인증 사용자(첫번째 로그인) -> 이메일 인증 필요!
                forwardPath="emailAuth";
            } else if(loginUser.getAuthStatus()==1) {
                //인증된 사용자
                System.out.println("로그인 성공");
                forwardPath = "index";
            }
        } catch (Exception e){
            e.printStackTrace();
            System.out.println("로그인 실패");
            forwardPath="login";
        }
        return forwardPath;
    }
    //2-3. 로그아웃 액션
    @GetMapping("/logout-action")
    public String logoutAction(HttpServletRequest request){
        request.getSession(false).invalidate();
        return "index";
    }
    //2-4. 이메일 인증 페이지
    @GetMapping("emailAuth")
    public String emailAuth(){
        return "emailAuth";
    }
    //2-5. 이메일 인증 액션
    @PostMapping("emailAuth-action")
    public ModelAndView emailAuthAction(HttpSession session,@RequestParam Map map, ModelAndView mv){
        String authKey=(String)map.get("authKey");
        Users loginUser=(Users)session.getAttribute("loginUser");
        System.out.println("인증을 위해 session에서 꺼낸 loginUser: "+loginUser);
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

    //3-1. 아이디 찾기 페이지
    @GetMapping("/findId")
    public String findId(){
        return "findId";
    }
    //3-2. 아이디 찾기 액션
    @PostMapping("/findId-action")
    public ModelAndView findIdAction(@RequestParam Map map, ModelAndView mv) throws Exception{
        String name=(String)map.get("name");
        String email=(String)map.get("email");
        try{
            String findId=usersService.findIdByNameEmail(name,email);
            mv.addObject("findId",findId);
            mv.setViewName("/findId");  //출력 창 만들기?
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //4-1. 비밀번호 찾기 페이지
    @GetMapping("/findPassword")
    public String findPassword(){
        return "findPassword";
    }
    //4-2. 비밀번호 찾기 액션 --> 메일로 임시 비밀번호 전송 후 로그인 하면 비밀번호 변경하기
    @PostMapping("/findPassword-action")
    public ModelAndView findPasswordAction(@RequestParam Map map, ModelAndView mv) throws Exception{
        String id=(String)map.get("id");
        String email=(String)map.get("email");
        try{
            System.out.println(id+email);
            int result=usersService.findPasswordByIdEmail(id,email);   //String으로 binding 에러?
            //int result=usersService.findPasswordByIdEmail(id2,email2);   //map으로 binding 에러?
            if(result == 1){
                //아이디 이메일 조합 존재 -> 메일로 임시 비번 발송
                Users users=usersService.findUsersById(id);
                String tempPassword = emailService.sendTempPasswordEmail(users.getEmail());
                //임시비밀번호 암호화한 뒤 DB변경
                String encryptTempPassword = sha256Service.encrypt(tempPassword);
                usersService.updatePassword(id,encryptTempPassword);
                mv.setViewName("login");
            }
        } catch (Exception e){
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

}
