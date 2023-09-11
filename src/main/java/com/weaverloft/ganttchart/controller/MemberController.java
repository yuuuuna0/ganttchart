package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.Interceptor.AdminCheck;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Member;
import com.weaverloft.ganttchart.dto.Ufile;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.MailService;
import com.weaverloft.ganttchart.util.PageMakerDto;
import com.weaverloft.ganttchart.util.Sha256Service;
import com.weaverloft.ganttchart.util.UploadFileService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/member/*")
public class MemberController {
    /****************기존*******************/
    private UsersService usersService;
    private SHA256Service sha256Service;
    private EmailService emailService;
    private FileService fileService;
    private UsersLogService usersLogService;
    private ExcelService excelService;
    private MenuService menuService;
    /******************************************/
    private MemberService memberService;
    private UfileService ufileService;
    private MailService mailService;
    private UploadFileService uploadFileService;


    public MemberController(UsersService usersService,
                            SHA256Service sha256Service,
                            EmailService emailService,
                            FileService fileService,
                            UsersLogService usersLogService,
                            ExcelService excelService,
                            MenuService menuService,
                            MemberService memberService,
                            UfileService ufileService,
                            MailService mailService,
                            UploadFileService uploadFileService) {
        this.usersService = usersService;
        this.sha256Service = sha256Service;
        this.emailService = emailService;
        this.fileService = fileService;
        this.usersLogService = usersLogService;
        this.excelService = excelService;
        this.menuService = menuService;
        this.memberService = memberService;
        this.ufileService = ufileService;
        this.mailService = mailService;
        this.uploadFileService = uploadFileService;
    }
    //1-1. 회원가입 페이지
    @GetMapping("/register")
    public String register(Model model){
        return "/user/register";
    }
    //1-2. 아이디 중복확인
    @ResponseBody
    @RequestMapping("/idCheck-ajax")
    public Map<String,Object> idCheckAjax(@RequestParam String id){
        Map<String,Object> resultMap = new HashMap<>();
        int code =0;
        String msg = "";
        try{
            if(memberService.findMemberById(id) == null){
                //존재하지 않으면
                code = 1;
                msg = "사용 가능한 아이디입니다.";
            } else{
                code = 2;
                msg = "이미 존재하는 아이디입니다.";
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요.";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        return resultMap;
    }


    @PostMapping("/register-ajax")
    public Map<String,Object> registerMemberAjax(@RequestParam Map<String,Object> map, MultipartHttpServletRequest mf){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String birthStr = (String)map.get("birth");
                Date birth = formatter.parse(birthStr);
                Member member = new Member((String)map.get("id"),
                (String)map.get("password"),
                (String)map.get("name"),
                (String)map.get("email"),
                (String)map.get("gender"),
                (String)map.get("phone"),
                new Date(),
                null,
                (String)map.get("address"),
                (String)map.get("detailedAddress"),
                Integer.parseInt(map.get("mTypeNo").toString()),
                0, 0,null,birth);
            //1) 아이디 중복확인
            if(memberService.findMemberById(member.getMId())!= null){
                System.out.println("이미 존재하는 아이디입니다.");
                code = 2;
                msg = "이미 존재하는 아이디입니다."; //--> 만일 중복검사 후에 아이디 변경하게 되면 다시 검사하는 방법은?
            }
            //2) 비밀번호 정규식 체크
            System.out.println("member.getMPassword() = " + member.getMPassword());
            Map<String,Object> passwordMap = memberService.isValidPassword(member.getMPassword());
            if(!(boolean)passwordMap.get("result")){
                msg = (String)passwordMap.get("msg");
                code=2;
                System.out.println(msg);
            }
            //3) 비밀번호 암호화
            String encPassword = sha256Service.encrypt(member.getMPassword());
            member.setMPassword(encPassword);
            //4) 인증메일 보내기msr
            String mAuthCode = mailService.sendMail(member.getMEmail(),1);
            member.setMAuthCode(mAuthCode);
            //5) 파일 업로드 --> 확장자 검사 필요
            if(mf.getFile("photoFile") !=null && !mf.getFile("photoFile").getOriginalFilename().equals("")){
                Ufile profileFile = uploadFileService.uploadFile(mf.getFile("photoFile"),1);
                profileFile.setMId(member.getMId());
                profileFile.setGathNo(0);
                profileFile.setReviewNo(0);
                ufileService.createMUfile(profileFile);
                System.out.println("profileFile = " + profileFile);
                int ufileNo = ufileService.findCurNo();
                member.setUfileNo(ufileNo);
            }
            //6) 회원가입완료
            member.setMStatusNo(0);
            memberService.createMember(member);
            code = 1;
            forwardPath = "/";
            //7) 로그 추가 ---> 아직 안함

        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요.";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
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
    @ResponseBody
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
            if(!password.equals(confirmPassword)){
                code = 2;
                msg = "비밀번호와 비밀번호확인은 일치하여야합니다.";
            }else if(!(boolean)usersService.isValidPassword(password).get("result")){
                code = 3;
                msg = "비밀번호 형식에 맞게 작성해주세요";
            } else {
                //2. 비밀번호 암호화
                String encryptPassword = sha256Service.encrypt(password);
                //3. 비밀번호 업데이트 및 인증상태 1로 변경
                int authStatus = 1;
                usersService.updatePassword(users.getId(), encryptPassword, authStatus);
                session.invalidate();
                code = 1;
                forwardPath = "/login";
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
        MultipartFile originalFile = multipartFile.getFile("photoFile");
        try{
            if(!originalFile.getOriginalFilename().equals("")){
                String filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\user\\";
                String saveFileName = fileService.uploadFile(originalFile,filePath);
                users.setFilePath(filePath);
                users.setSaveFileName(saveFileName);
                users.setOriginalFileName(originalFile.getOriginalFilename());
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
//            //cm_left data
//            Map<String, Object> map = menuService.cmLeftMenuList();
//            model.addAttribute("menuList", map.get("menuList"));
//            model.addAttribute("preMenuList",map.get("preMenuList"));
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
//            //cm_left data
//            Map<String, Object> map = menuService.cmLeftMenuList();
//            model.addAttribute("menuList", map.get("menuList"));
//            model.addAttribute("preMenuList",map.get("preMenuList"));
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
