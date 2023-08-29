package com.weaverloft.ganttchart.controller;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.Interceptor.AdminCheck;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
    private EmailService emailService;
    private FileService fileService;
    private UsersLogService usersLogService;
    private ExcelService excelService;
    private MenuService menuService;

    public UsersController(UsersService usersService,
                           SHA256Service sha256Service,
                           EmailService emailService,
                           FileService fileService,
                           UsersLogService usersLogService,
                           ExcelService excelService,
                           MenuService menuService) {
        this.usersService = usersService;
        this.sha256Service = sha256Service;
        this.emailService = emailService;
        this.fileService = fileService;
        this.usersLogService = usersLogService;
        this.excelService = excelService;
        this.menuService = menuService;
    }
    //1-1. 회원가입 페이지
    @GetMapping("/user/register")
    public String register(Model model){
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }
        return "/user/register";
    }
    //1-2. 회원가입 액션 --> 파일업로드, 비밀번호 정규식 체크, 한글 입력 꺠지는 것 해결해야 함
    @ResponseBody
    @PostMapping(value = "/user/register-action")
    public String registerAction(@ModelAttribute Users users, MultipartHttpServletRequest multipartFile) throws Exception{
        String forwardPath = "";
        MultipartFile photoFile = multipartFile.getFile("photoFile");
        try {
            if (usersService.findUsersById(users.getId())!=null) {
                //1) 아이디 중복 확인
                System.out.println("이미 존재하는 아이디입니다.");
                forwardPath = "redirect:/login";
                return forwardPath;
            }
            if(usersService.isValidPassword(users.getPassword())){
                //2) 비밀번호 정규식 체크 --> 적용 안됨,, 왜죠?
                System.out.println("비밀번호는 영문,숫자,특수문자를 포함한 6글자 이상 15글자 이하여야합니다.");
                forwardPath ="redirect:/register";
                return forwardPath;
            }
            //3) 비밀번호 암호화
            String encryptPassword = sha256Service.encrypt(users.getPassword());
            users.setPassword(encryptPassword);
            //4) 인증메일 보내기 -> 임의의 authKey 생성 & 이메일 발송
            int authKey = emailService.sendAuthEmail(users.getEmail());
            String authKeyStr = Integer.toString(authKey);
            users.setAuthKey(authKeyStr);
            //5) 파일 업로드
            if(photoFile !=null){
                String filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\users\\";
                String photo = fileService.uploadFile(photoFile,filePath);
                users.setPhoto(photo);
                System.out.println("사진 있다");
            } else{
                String photo = "default.jpg";
                users.setPhoto(photo);
            }
            //6) 회원가입 완료
            int result = usersService.createUsers(users);
            //7) 회원가입 로그 추가
            String id= users.getId();
            System.out.println(id);
            usersLogService.createLog(id,0);    //가입완료 로그:0 남기기
            forwardPath = "redirect:/login";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //2-1. 로그인 페이지 --> 완료
    @GetMapping("/login")
    public String login(){
        return "/login";
    }
    //2-2. 로그인 액션 --> 완료
    @PostMapping("/login-action")
    public String loginAction(HttpSession session, @RequestParam Map map) {
        String forwardPath = "";
        String id=(String)map.get("id");
        String password=(String)map.get("password");
        try{
            Users loginUser=usersService.login(id,sha256Service.encrypt(password));
            session.setAttribute("loginUser", loginUser);
            session.setMaxInactiveInterval(60 * 30);    //세션 유지시간 설정 :30분
            if(loginUser.getAuthStatus() == 0){
                //미인증 사용자(첫번째 로그인)
                forwardPath = "redirect:/user/emailAuth";
            } else if(loginUser.getAuthStatus()==1) {
                //인증된 사용자
                int result=usersLogService.createLog(loginUser.getId(),10);
                forwardPath = "redirect:/";
            }
        } catch (Exception e){
            e.printStackTrace();
            System.out.println("로그인 실패");
            forwardPath = "redirect:/login";
        }
        return forwardPath;
    }
    //2-3. 로그아웃 액션 --> 완료
    @LoginCheck
    @RequestMapping("/logout-action")
    public String logoutAction(HttpSession session) {
        String forwardPath = "";
        try{
            Users users=(Users)session.getAttribute("loginUser");
            session.invalidate();
            usersLogService.createLog(users.getId(),11);
            forwardPath = "redirect:/";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //2-4. 이메일 인증 페이지 --> 완료
    @LoginCheck
    @GetMapping("/user/emailAuth")
    public String emailAuth(Model model){
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }
        return "/user/emailAuth";
    }
    //2-5. 이메일 인증 액션 --> 완료
    @LoginCheck
    @PostMapping("/user/emailAuth-action")
    public String emailAuthAction(HttpSession session,@RequestParam Map map){
        String forwardPath = "";
        String authKey=(String)map.get("authKey");
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            if(authKey.equals(loginUser.getAuthKey())){
                usersService.updateAuthStatus1(loginUser.getId());   //회원 인증 완료
                usersLogService.createLog(loginUser.getId(),1);        //인증완료 로그:1 남기기
                usersLogService.createLog(loginUser.getId(),10);        //로그인 로그:10 남기기
                session.setAttribute("loginUser",loginUser);
                forwardPath = "redirect:/";
            } else{
                System.out.println("인증번호가 다릅니다");
                forwardPath = "redirect:/user/emailAuth";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3-1. 아이디 찾기 페이지 --> 완료
    @GetMapping("/user/findId")
    public String findId(){
        return "/user/findId";
    }
    //3-2. 아이디 찾기 액션 --> 완료, ID 출력 페이지 만들어야함 --> ajax
    @PostMapping("/user/findId-ajax")
    public Map<String,Object> findIdAjax(@RequestParam Map map) {
        Map<String, Object> resultMap = new HashMap<>();
        int code = 1;
        String msg = "성공";
        String data = "";
        String name=(String)map.get("name");
        String email=(String)map.get("email");
        try{
            String findId=usersService.findIdByNameEmail(name,email);
            data = findId;
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "실패";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("data", data);
        return resultMap;
    }
    //4-1. 비밀번호 찾기 페이지 --> 완료
    @GetMapping("/user/findPassword")
    public String findPassword(){
        return "/user/findPassword";
    }
    //4-2. 비밀번호 찾기 액션 --> 완료
    @PostMapping("/user/findPassword-action")
    public String findPasswordAction(@RequestParam Map map) {
        String forwardPath = "";
        String id=(String)map.get("id");
        String name = (String)map.get("name");
        String email=(String)map.get("email");
        try{
            int result=usersService.findPasswordByIdNameEmail(id,name,email);   //String으로 binding 에러?
            if(result == 1){
                Users users=usersService.findUsersById(id);
                //아이디 이메일 조합 존재 -> 메일로 임시 비번 발송
                String tempPassword = emailService.sendTempPasswordEmail(users.getEmail());
                System.out.println("임시비번 전송 성공");
                //임시비밀번호 암호화한 뒤 DB변경
                String encryptTempPassword = sha256Service.encrypt(tempPassword);
                System.out.println("임시비번 암호화: "+encryptTempPassword);
                usersService.updatePassword(id,encryptTempPassword);
                forwardPath = "redirect:/login";
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //5.마이페이지 --> 완료
    @LoginCheck
    @GetMapping(value="/user/detail")
    public String mypage( HttpSession session,Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            Users loginUser=(Users)session.getAttribute("loginUser");
            model.addAttribute("loginUser",loginUser);
            forwardPath = "/user/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //6-1. 정보 수정 페이지
    @LoginCheck
    @GetMapping("/user/modify")
    public String modifyUser( HttpSession session, Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            Users loginUser = (Users)session.getAttribute("loginUser");
            model.addAttribute("loginUser",loginUser);

        } catch (Exception e){
            e.printStackTrace();
        }
        forwardPath = "/user/modify";
        return forwardPath;
    }
    //6-2. 정보 수정 액션
    @LoginCheck
    @PostMapping("/user/modifyUser-action")
    public String modifyUserAction(@ModelAttribute Users users, HttpSession session, MultipartHttpServletRequest multipartFile){
        String forwardPath ="";
        Users loginUser = (Users)session.getAttribute("loginUser");
        MultipartFile photoFile = multipartFile.getFile("photoFile");
        String photo="";
        try{
            if(photoFile !=null){
                String filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\users\\";
                photo = fileService.uploadFile(photoFile,filePath);
                users.setPhoto(photo);
            } else{
                photo = loginUser.getPhoto();
            }
            int result = usersService.updateUsers(users);
            Users updateUser = usersService.findUsersById(loginUser.getId());
            session.setAttribute("loginUser",updateUser);   //업데이트 한 유저 세션에 담기
            forwardPath = "redirect:/user/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //7. 회원탈퇴 --> 완료
    @LoginCheck
    @GetMapping("/user/delete-action")
    public String deleteUserAction(HttpSession session){
        String forwardPath="";
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            usersLogService.createLog(loginUser.getId(),999);   //탈퇴 로그:999 남기기
            int result=usersService.deleteUsers(loginUser.getId());
            session.invalidate();
            forwardPath="redirect:/";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


    //1. 회원리스트 출력
    @AdminCheck
    @GetMapping("/user/list/{pageNo}")
    public String userList(@PathVariable int pageNo,
                                 @RequestParam(required = false) String keyword,
                                 HttpSession session,
                                 Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            PageMakerDto userListPage = usersService.findUserList(pageNo,keyword);
            model.addAttribute("userListPage",userListPage);
            forwardPath = "/user/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //2. 회원 로그 출력
    @AdminCheck
    @GetMapping("/user/log/{pageNo}")
    public String userLog(@PathVariable int pageNo,
                                @RequestParam(required = false) String keyword,
                                HttpSession session,
                                Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            PageMakerDto usersLogPage = usersLogService.findUserLog(pageNo,keyword);
            model.addAttribute("usersLogPage",usersLogPage);
            forwardPath = "/user/log";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //엑셀 다운로드
    @RequestMapping("/download")
    public void excelDown( HttpServletRequest request, HttpServletResponse response) throws Exception{
        excelService.excelDown(response,"회원리스트");
    }




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

