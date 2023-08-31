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
import java.util.*;

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
    //1-2. 아이디 중복확인
    @ResponseBody
    @PostMapping("/user/idCheck-ajax")
    public int idCheckAjax(@RequestParam String id){
        int idCount = 0;
        try{
            idCount = usersService.isExistedId(id);
        } catch (Exception e){
            e.printStackTrace();
        }
        return idCount;
    }

    //1-2. 회원가입 액션 --> 파일업로드, 비밀번호 정규식 체크, 한글 입력 꺠지는 것 해결해야 함
    @PostMapping(value = "/user/register-action")
    public String registerAction(@ModelAttribute Users users, MultipartHttpServletRequest multipartFile) throws Exception{
        String forwardPath = "";
        try {
            if (usersService.findUsersById(users.getId())!=null) {
                //1) 아이디 중복 확인
                System.out.println("이미 존재하는 아이디입니다.");
                forwardPath = "redirect:/login";
                return forwardPath;
            }
            if(!usersService.isValidPassword(users.getPassword())){
                //2) 비밀번호 정규식 체크
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
            if(multipartFile !=null){
                MultipartFile originalFile = multipartFile.getFile("photoFile");
                String filePath = "C:\\gantt\\upload\\users\\";
                String saveFileName = fileService.uploadFile(originalFile,filePath);
                users.setFilePath(filePath);
                users.setSaveFileName(saveFileName);
                users.setOriginalFileName(originalFile.getName());
                System.out.println("사진 있다");
            } else{
                //이거 안해줘도 되는지?
                users.setFilePath(null);
                users.setSaveFileName(null);
                users.setOriginalFileName(null);
            }
            //6) 회원가입 완료
            users.setGrade(1);
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
    @ResponseBody
    @PostMapping("/login-ajax")
    public Map<String,Object> loginAjax(HttpSession session,@RequestParam String id, @RequestParam String password) {
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "성공";
        String forwardPath = "";
        try{
//            String encryptPassword = sha256Service.encrypt(password);
            Users loginUser= usersService.login(id,sha256Service.encrypt(password));
            if(loginUser == null){
                //ID&PW 조합 틀림
                code =2;
                msg = "존재하지 않는 아이디거나 비밀번호가 틀립니다.";
                forwardPath = "/login";
            } else {
                if(loginUser.getAuthStatus()==1) {
                    //인증된 사용자
                    code = 1;
                    usersLogService.createLog(loginUser.getId(),10);
                    forwardPath = "/index";
                }
                if(loginUser.getAuthStatus() == 0){
                    //미인증 사용자(첫번째 로그인)
                    code = 3;
                    forwardPath = "/user/emailAuth";
                }
                if(loginUser.getAuthStatus()==2){
                    //임시비번으로 로그인 한 사람
                    code = 4;
                    usersLogService.createLog(loginUser.getId(),10);
                    forwardPath = "/user/modifyPassword";
                }
                session.setAttribute("loginUser", loginUser);
                session.setMaxInactiveInterval(60 * 30);    //세션 유지시간 설정 :30분
            }
        } catch (Exception e){
            e.printStackTrace();
            code=5;
            msg = "로그인 실패. 관리자에게 문의하세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //2-3. 로그아웃 액션 --> 완료
    @LoginCheck
    @RequestMapping("/logout-action")
    public String logoutAjax(HttpSession session) {
        String forwardPath = "";
        try{
            Users users=(Users)session.getAttribute("loginUser");
            session.invalidate();
            usersLogService.createLog(users.getId(),11);
            forwardPath = "redirect:/index";
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
    @ResponseBody
    @PostMapping("/user/emailAuth-ajax")
    public Map<String,Object> emailAuthAjax(HttpSession session,@RequestParam Map map){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "성공";
        String forwardPath = "";
        String authKey=(String)map.get("authKey");
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            if(loginUser.getAuthKey().equals(authKey)){
                code = 1;
                usersService.updateAuthStatus1(loginUser.getId());   //회원 인증 완료
                usersLogService.createLog(loginUser.getId(),1);        //인증완료 로그:1 남기기
                usersLogService.createLog(loginUser.getId(),10);        //로그인 로그:10 남기기
                session.setAttribute("loginUser",loginUser);
                forwardPath = "/index";
            } else{
                code = 2;
                msg="인증번호가 다릅니다";
                forwardPath = "/user/emailAuth";
            }
        }catch (Exception e){
            e.printStackTrace();
            code = 3;
            msg = "알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요";
            forwardPath="/error";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //3-1. 아이디 찾기 페이지 --> 완료
    @GetMapping("/user/findId")
    public String findId(Model model){
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }return "/user/findId";
    }
    //3-2. 아이디 찾기 액션
    @ResponseBody
    @PostMapping("/user/findId-ajax")
    public Map<String,Object> findIdAjax(@RequestParam Map map) {
        Map<String, Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "성공";
        List<String> data = new ArrayList<>();
        String name=(String)map.get("name");
        String email=(String)map.get("email");
        try{
            List<String> findIdList=usersService.findIdByNameEmail(name,email);
            data = findIdList;
            code = 1;
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
    public String findPassword(Model model){
    try{
        //cm_left data
        Map<String, Object> map = menuService.cmLeftMenuList();
        model.addAttribute("menuList", map.get("menuList"));
        model.addAttribute("preMenuList",map.get("preMenuList"));
    } catch (Exception e){
        e.printStackTrace();
    }
        return "/user/findPassword";
    }
    //4-2. 비밀번호 찾기 액션 --> 완료
    @ResponseBody
    @PostMapping("/user/findPassword-ajax")
    public Map<String,Object> findPasswordAjax(@RequestParam Map map) {
        Map<String, Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "성공";
        String forwardPath = "";
        String id=(String)map.get("id");
        String name = (String)map.get("name");
        String email=(String)map.get("email");
        try{
            int result = usersService.findPasswordByIdNameEmail(id,name,email);   //String으로 binding 에러?
            if(result == 1){
                Users users=usersService.findUsersById(id);
                //아이디 이메일 조합 존재 -> 메일로 임시 비번 발송
                String tempPassword = emailService.sendTempPasswordEmail(users.getEmail());
                //임시비밀번호 암호화한 뒤 DB변경
                String encryptTempPassword = sha256Service.encrypt(tempPassword);
                int authStatus = 2; //비번 변경시 계정상태 2으로 변경 남기기
                usersService.updatePassword(id,encryptTempPassword,authStatus);
                code = 1;
                msg = "가입시 입력한 메일로 임시비밀번호 전송하였습니다.";
                forwardPath = "/login";
            } else {
                Users users = usersService.findUsersById(id);
                result = usersService.findIdByNameEmail(name,email).size();
                if(users == null){
                    code = 2;
                    msg = "가입된 아이디가 존재하지 않습니다.";
                } else if(result == 0){
                   code = 3;
                   msg = "해당 이름과 이메일을 가진 아이디가 존재하지 않습니다.";
                }
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 4;
            msg = "알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요";
            forwardPath="/error";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //4. 비밀번호 변경 페이지
    @LoginCheck
    @GetMapping("/user/modifyPassword")
    public String modifyPassword(Model model){
        String forwardPath="";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
            forwardPath="/user/modifyPassword";

        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //4-1. 비밀번호 변경 액션
    @LoginCheck
    @PostMapping("/user/modifyPassword-ajax")
    public Map<String,Object> modifyPasswordAction(HttpSession session, @RequestParam Map map){
        Map<String, Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "성공";
        String forwardPath = "";
        String password = (String)map.get("password");
        String confirmPassword = (String)map.get("confirmPassword");
        try{
            Users users=(Users)session.getAttribute("loginUser");
            if(password.equals(confirmPassword)){
                code = 2;
                msg = "비밀번호와 비밀번호확인은 일치하여야합니다.";
            } else if(!usersService.isValidPassword(password)){
                //1. 비밀번호 정규식 체크
                code = 3;
                msg = "비밀번호 형식에 맞게 작성해주세요";
            } else {
                //2. 비밀번호 암호화
                String encryptPassword = sha256Service.encrypt(password);
                //3. 비밀번호 업데이트 및 인증상태 1로 변경
                int authStatus = 1;
                usersService.updatePassword(users.getId(),encryptPassword,authStatus);
                session.invalidate();
                code = 1;
                forwardPath="/login";
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 4;
            msg = "알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요";
            forwardPath = "/error";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
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

        try{
            if(multipartFile !=null){
                MultipartFile originalFile = multipartFile.getFile("photoFile");
                String filePath = "C:\\gantt\\upload\\users\\";
                String saveFileName = fileService.uploadFile(originalFile,filePath);
                users.setFilePath(filePath);
                users.setSaveFileName(saveFileName);
                users.setOriginalFileName(originalFile.getName());
            } else{
                users.setFilePath(loginUser.getFilePath());
                users.setSaveFileName(loginUser.getSaveFileName());
                users.setOriginalFileName(loginUser.getOriginalFileName());
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
            forwardPath="redirect:/index";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

/******************************************************************************************************************************************************/


    //1. 회원리스트 출력
    @AdminCheck
    @GetMapping("/user/list")
    public String userList(@RequestParam(required = false, defaultValue = "1") int pageNo,
                                 @RequestParam(required = false, defaultValue = "") String keyword,
                                 HttpSession session,
                                 Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
            //데이터 처리부분
            if(keyword.equals("")) keyword=null;
            PageMakerDto userListPage = usersService.findUserList(pageNo,keyword);
            model.addAttribute("userListPage",userListPage);
            model.addAttribute("keyword",keyword);
            forwardPath = "/user/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


    //2. 회원 로그 출력
    @AdminCheck
    @GetMapping("/user/log")
    public String userLog(@RequestParam(required = false, defaultValue = "1") int pageNo,
                                @RequestParam(required = false, defaultValue = "") String keyword,
                                HttpSession session,
                                Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
            //데이터처리부분
            if(keyword.equals("")) keyword=null;
            PageMakerDto usersLogPage = usersLogService.findUserLog(pageNo,keyword);
            model.addAttribute("usersLogPage",usersLogPage);
            model.addAttribute("keyword",keyword);
            forwardPath = "/user/log";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //엑셀 다운로드
    @RequestMapping("/download")
    public void excelDown( HttpServletRequest request, HttpServletResponse response) {
        try{
            excelService.excelDown(response,"회원리스트");
        } catch (Exception e){
            e.printStackTrace();
        }
    }




}
