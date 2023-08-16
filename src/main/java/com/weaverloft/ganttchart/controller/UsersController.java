package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

@Controller
public class UsersController {
    private UsersService usersService;
    private SHA256Service sha256Service;
    private EmailService emailService;
    private FileService fileService;
    private UsersLogService usersLogService;

    public UsersController(UsersService usersService,
                           SHA256Service sha256Service,
                           EmailService emailService,
                           FileService fileService,
                           UsersLogService usersLogService) {
        this.usersService = usersService;
        this.sha256Service = sha256Service;
        this.emailService = emailService;
        this.fileService = fileService;
        this.usersLogService = usersLogService;
    }
    //1-1. 회원가입 페이지
    @GetMapping("/register")
    public String register(){
        return "register";
    }
    //1-2. 회원 이미지 업로드
    @RequestMapping("/uploadPhoto")
    public void uploadPhoto(MultipartFile photoFile) throws Exception{
        String photo;
        try{
            if(photoFile == null){
                photo = "default.jpg";
            }
            photo = fileService.uploadFile(photoFile);
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    //1-2. 회원가입 액션 --> 파일업로드, 비밀번호 정규식 체크, 한글 입력 꺠지는 것 해결해야 함
    @ResponseBody
    @PostMapping(value = "register-action")
    public ModelAndView registerAction(@ModelAttribute Users users, MultipartFile multipartFile, ModelAndView mv) throws Exception{
        MultipartFile photoFile = multipartFile;
        try {
            if (usersService.findUsersById(users.getId())!=null) {
                //1) 아이디 중복 확인
                System.out.println("이미 존재하는 아이디입니다.");
                mv.setViewName("redirect:/login");
                return mv;
            }
/*
            if(usersService.isValidPassword(password)){
                //2) 비밀번호 정규식 체크 --> 적용 안됨,, 왜죠?
                System.out.println("비밀번호는 영문,숫자,특수문자를 포함한 8글자 이상 15글자 이하여야합니다.");
                mv.setViewName("redirect:/register");
                return mv;
            }
*/
            //3) 비밀번호 암호화
            String encryptPassword = sha256Service.encrypt(users.getPassword());
            users.setPassword(encryptPassword);
            //4) 인증메일 보내기 -> 임의의 authKey 생성 & 이메일 발송
            int authKey = emailService.sendAuthEmail(users.getEmail());
            String authKeyStr = Integer.toString(authKey);
            users.setAuthKey(authKeyStr);
            //5) 파일 업로드
            if(photoFile !=null){
                String photo = fileService.uploadFile(photoFile);
                users.setPhoto(photo);
            } else{
                String photo = "default.jpg";
                users.setPhoto(photo);
            }
            //6) 회원가입 완료
            int result = usersService.createUsers(users);
            //7) 회원가입 로그 추가
            String id= users.getId();
            System.out.println(id);
            //usersLogService.registerUser(id);       //에러남 -> missing select keyword
            mv.setViewName("redirect:/login");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    //2-1. 로그인 페이지 --> 완료
    @GetMapping("/login")
    public String login(){
        return "login";
    }
    //2-2. 로그인 액션 --> 완료
    @PostMapping("/login-action")
    public ModelAndView loginAction(HttpSession session,ModelAndView mv,
                                    @RequestParam Map map) throws Exception{
        String id=(String)map.get("id");
        String password=(String)map.get("password");
        try{
            Users loginUser=usersService.login(id,sha256Service.encrypt(password));
            System.out.println(loginUser);
            session.setAttribute("loginUser", loginUser);
            if(loginUser.getAuthStatus()==0){
                //미인증 사용자(첫번째 로그인)
                mv.setViewName("redirect:/emailAuth");
            } else if(loginUser.getAuthStatus()==1) {
                //인증된 사용자
                System.out.println("로그인 성공");
                int result=usersLogService.loginUser(loginUser.getId());
                mv.addObject("loginUser",loginUser);
                mv.setViewName("redirect:/");
            }
        } catch (Exception e){
            e.printStackTrace();
            System.out.println("로그인 실패");
            mv.setViewName("redirect:/login");
        }
        return mv;
    }
    //2-3. 로그아웃 액션 --> 완료
    @GetMapping("/logout-action")
    public String logoutAction(HttpSession session) throws Exception{
        Users users=(Users)session.getAttribute("loginUser");
        session.invalidate();
        usersLogService.logoutUser(users.getId());
        return "redirect:/";
    }
    //2-4. 이메일 인증 페이지 --> 완료
    @GetMapping("emailAuth")
    public String emailAuth(){
        return "emailAuth";
    }
    //2-5. 이메일 인증 액션 --> 완료
    @PostMapping("emailAuth-action")
    public ModelAndView emailAuthAction(HttpSession session,@RequestParam Map map, ModelAndView mv){
        String authKey=(String)map.get("authKey");
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            if(authKey.equals(loginUser.getAuthKey())){
                usersService.updateAuthStatus(loginUser.getId());   //회원 인증 완료
                usersLogService.authUser(loginUser.getId());        //로그남기기
            } else{
                System.out.println("인증번호가 다릅니다");   //인증이 안됨,,,,
                mv.setViewName("redirect:/emailAuth");
            }
            session.setAttribute("loginUser",loginUser);
            mv.setViewName("redirect:/");
        }catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    //3-1. 아이디 찾기 페이지 --> 완료
    @GetMapping("/findId")
    public String findId(){
        return "findId";
    }
    //3-2. 아이디 찾기 액션 --> 완료, ID 출력 페이지 만들어야함
    @PostMapping("/findId-action")
    public ModelAndView findIdAction(@RequestParam Map map, ModelAndView mv) throws Exception{
        String name=(String)map.get("name");
        String email=(String)map.get("email");
        try{
            String findId=usersService.findIdByNameEmail(name,email);
            mv.addObject("findId",findId);
            mv.setViewName("complete");  //출력 창 만들기?
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //4-1. 비밀번호 찾기 페이지 --> 완료
    @GetMapping("/findPassword")
    public String findPassword(){
        return "findPassword";
    }
    //4-2. 비밀번호 찾기 액션 --> 완료
    @PostMapping("/findPassword-action")
    public ModelAndView findPasswordAction(@RequestParam Map map, ModelAndView mv) throws Exception{
        String id=(String)map.get("id");
        String email=(String)map.get("email");
        try{
            System.out.println("id: "+id+" / email: "+email);
            int result=usersService.findPasswordByIdEmail(id,email);   //String으로 binding 에러?
            if(result == 1){
                Users users=usersService.findUsersById(id);
                //아이디 이메일 조합 존재 -> 메일로 임시 비번 발송
                String tempPassword = emailService.sendTempPasswordEmail(users.getEmail());
                System.out.println("임시비번 전송 성공");
                //임시비밀번호 암호화한 뒤 DB변경
                String encryptTempPassword = sha256Service.encrypt(tempPassword);
                System.out.println("임시비번 암호화: "+encryptTempPassword);
                usersService.updatePassword(id,encryptTempPassword);
                mv.setViewName("login");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    //5.마이페이지 --> 완료
    @GetMapping(value="mypage")
    public ModelAndView mypage(HttpSession session,ModelAndView mv){
        try{
            Users loginUser=(Users)session.getAttribute("loginUser");
            if(loginUser==null){
                mv.setViewName("redirect:/login");
                return mv;
            }
            mv.addObject("loginUser",loginUser);
            mv.setViewName("mypage");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    //6-1. 정보 수정 페이지
    @GetMapping(value="modifyUser", params = "id")
    public ModelAndView modifyUser(HttpSession session, ModelAndView mv){
        Users loginUser = (Users)session.getAttribute("loginUser");
        mv.addObject(loginUser);
        mv.setViewName("modifyUser");
        return mv;
    }
    //6-2. 정보 수정 액션
    @PostMapping("modifyUser")
    public ModelAndView modifyUserAction(@RequestParam Map map, ModelAndView mv){
        String name=(String)map.get("name");
        Date birth=(Date)map.get("birth");
        String genderStr=(String)map.get("gender");
        int gender=Integer.parseInt(genderStr);
        String phone=(String)map.get("phone");
        String address=(String)map.get("address");
        String email=(String)map.get("email");
        try{
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //6-2. 회원탈퇴 --> 완료
    @GetMapping(value="deleteUser-action", params="id")
    public String deleteUserAction(HttpSession session){
        String forwardPath="";
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            int result=usersService.deleteUsers(loginUser.getId());
            session.invalidate();
            forwardPath="redirect:login";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
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
