package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.dto.*;
import com.weaverloft.ganttchart.util.EmailService;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user/*")
public class UserController {
    private UsersService usersService;
    private FilesService filesService;
    private EmailService emailService;
    private BoardService boardService;
    private ApplyService applyService;
    private GatheringService gatheringService;


    public UserController(UsersService usersService, FilesService filesService,EmailService emailService,BoardService boardService,ApplyService applyService,GatheringService gatheringService) {
        this.usersService = usersService;
        this.filesService = filesService;
        this.emailService = emailService;
        this.boardService = boardService;
        this.applyService = applyService;
        this.gatheringService = gatheringService;
    }

    //1. 회원가입 페이지
    @GetMapping("/register")
    public String registerPage(){
        String forwardPath = "";
        try{
            forwardPath = "/user/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1 아이디 중복체크 AJAX
    @ResponseBody
    @PostMapping("/idCheck")
    public Map<String,Object> idCheckAjax(@RequestParam String id){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        try{
            Users existedUser = usersService.findUserById(id);
            if(existedUser == null){
                code = 1;
                msg = "사용 가능한 아이디입니다.";
            } else {
                code = 2;
                msg = "이미 존재하는 아이디입니다.";
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        return resultMap;
    }
    //1-2. 회원가입액션 AJAX --> 이메일 문제 해결
    @ResponseBody
    @PostMapping("/register.ajx")
    public Map<String,Object> registerAjax(Users user, @RequestPart(required = false) MultipartFile mf){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            //1) 아이디 중복확인 --- 사용자가 중복확인 완료 후에 아이디를 변경했을 경우 잡아내는 방법
            if(usersService.findUserById(user.getUId()) != null){
                code = 2;
                msg = "이미 존재하는 아이디입니다.";
            }
            //2) 비밀번호 정규식 체크
            if(!usersService.isValidPassword(user.getUPassword())){
                code = 2;
                msg = "비밀번호는 영문,숫자,특수문자를 포함한 6글자 이상 12글자 이하로, 공백이 포함될 수 없습니다.";
            }
            //3) 인증메일 발송 --> recipient address is not a valid address 에러
//            String uAuthCode = emailService.sendMail(user.getUId(),1);
//            user.setUAuthCode(uAuthCode);
            //4) 회원가입 완료 --- 직전에 업로드한 fileNo curval 찾아서 회원에 넣어준다. + fileNo 0 만들어야 fk 위반 안하나?
            int result = usersService.createUsers(user);
            if(result == 1) {
                code = 1;
                msg = "가입하신 이메일로 인증번호가 전송되었습니다.";
                forwardPath = "/user/login";
            }
            //5) 사진 업로드 --- 확장자 검사 필요함
            if(mf != null){
                System.out.println("사진있음");
                Map<String,Object> map = filesService.uploadFile(mf,1);
                Files file = new Files(0,
                                        (String)map.get("saveName"),
                                        (String)map.get("originalName"),
                                        (String)map.get("filePath"),
                                        (String)map.get("fileExt"),
                                        "Y",
                                        user.getUId(),
                                        0,0,0,
                                        (Long)map.get("fileSize"));
                filesService.createFile(file,1);
                int fileNo = filesService.findCurFileNo();
                usersService.updateFileNo(user.getUId(),fileNo);
            }
            //7) 로그 추가

        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //2. 로그인 페이지
    @GetMapping("/login")
    public String loginPage(){
        String forwardPath ="";
        try{
            forwardPath = "/user/login";
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //2-1. 로그인액션 AJAX
    @ResponseBody
    @PostMapping("/login.ajx")
    public Map<String,Object> loginAjax(@RequestParam String uId, @RequestParam String uPassword, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users user = usersService.findUserById(uId);
            if(user == null){
                code = 4;
                msg = "존재하지 않는 아이디이거나 비밀번호가 일치하지 않습니다.";
            } else{
                boolean result = usersService.login(uId,uPassword,user.getUPassword());
                if(!result){
                    code = 4;
                    msg = "존재하지 않는 아이디이거나 비밀번호가 일치하지 않습니다.";
                } else {
                    switch (user.getUStatusNo()) {
                        case 1:     //이메일 인증 전
                            code = 2;
                            forwardPath = "/user/emailAuth";
                            break;
                        case 2:     //이메일 인증 후
                            code = 1;
                            forwardPath = "/";
                            break;
                        case 3:     //임시비번상태
                            code = 3;
                            forwardPath = "/user/modifyPassword";
                            break;
                        case 98:    //휴면계정 --> 어떻게 처리할지?
                            code = 98;
                            break;
                    }
                    session.setAttribute("loginUser", user);
                    session.setMaxInactiveInterval(60 * 30);  //세션유지 30분
                }
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //2-2. 로그아웃 액션
    @RequestMapping("/logout.action")
    public String logoutAction(HttpSession session){
        String forwardPath = "";
        try{
            session.invalidate();
            forwardPath = "redirect:/";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 이메일 인증 페이지
    @GetMapping("/emailAuth")
    public String emailAuthPage(){
        String forwatdPath ="";
        try{
            forwatdPath="/user/emailAuth";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwatdPath;
    }
    //3-1. 이메일 인증하기 AJAX
    @ResponseBody
    @PostMapping("/emailAuth.ajx")
    public Map<String,Object> emailAuthAjax(HttpSession session,@RequestParam String uAuthCode){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            if(!loginUser.getUAuthCode().equals(uAuthCode)){
                code = 2;
                msg = "인증번호가 일치하지 않습니다.";
            }
            int result = usersService.updateUStatusNo(loginUser.getUId(),2);
            code = 1;
            forwardPath = "/";
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //4. 아이디 찾기 페이지
    @GetMapping("/findId")
    public String findIdPage(){
        String forwardPath ="";
        try{
            forwardPath = "/user/findId";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //4-1. 아이디 찾기 AJAX
    @ResponseBody
    @PostMapping("/findId.ajx")
    public Map<String,Object> findIdAjax(@RequestParam String uName, @RequestParam String uEmail){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            List<String> uIdList = usersService.findIdByNameEmail(uName,uEmail);
            if(uIdList.size() == 0){
                code = 2;
                msg = "입력하신 이름, 이메일로 가입한 회원이 존재하지 않습니다.";
            } else {
                code = 1;
                resultMap.put("data",uIdList);
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        return resultMap;
    }
    //5. 비밀번호 찾기 페이지
    @GetMapping("/findPassword")
    public String findPasswordPage(){
        String forwardPath="";
        try{
            forwardPath = "/user/findPassword";
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //5-1. 비밀번호 찾기 -> 임시비번 전송 AJAX
    @ResponseBody
    @PostMapping("/findPassword.ajx")
    public Map<String,Object> findPasswordAjax(@RequestParam String uId, @RequestParam String uName, @RequestParam String uEmail){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users user = usersService.findUserById(uId);
            if (user == null) {
                code = 2;
                msg = "입력하신 정보와 일치하는 회원이 존재하지 않습니다.";
            }
            if(user.getUName().equals(uName) && user.getUEmail().equals(uEmail)){
                code = 1;
                String tempPassword = emailService.sendMail(uEmail,2);
                usersService.updatePassword(uId,tempPassword);
                usersService.updateUStatusNo(uId,3);
                msg = "가입하신 이메일로 임시비밀번호가 전송되었습니다.";
                forwardPath ="/user/login";
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //5-2. 비밀번호 변경 페이지
    @GetMapping("/modifyPassword")
    public String modifyPasswordPage(){
        String forwardPath="";
        try{
            forwardPath = "/user/modifyPassword";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //5-3. 비밀번호 변경 ajax
    @ResponseBody
    @PostMapping("/modifyPassword.ajx")
    public Map<String,Object> modifyPasswordAjax(@RequestParam String uPassword,HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            usersService.updatePassword(loginUser.getUId(),uPassword);
            usersService.updateUStatusNo(loginUser.getUId(),2);
            code = 1;
            forwardPath = "/user/logout.action";
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //6. 마이페이지
    @GetMapping(value="/detail")
    public String detailPage(@RequestParam String uId,Model model){
        String forwardPath ="";
        try{
            Users user = usersService.findUserById(uId);
            Files file = filesService.findFileByNo(user.getFileNo());
            System.out.println("file = " + file);
            model.addAttribute("file",file);
            forwardPath="/user/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //7. 정보수정페이지
    @GetMapping(value="/modify")
    public String modifyPage(@RequestParam String uId, Model model){
        String forwardPath ="";
        try{
            Users user = usersService.findUserById(uId);
            Files file = filesService.findFileByNo(user.getFileNo());
            model.addAttribute("user",user);
            model.addAttribute("file",file);
            forwardPath="/user/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //7-1 정보수정 AJAX
    @ResponseBody
    @PostMapping("/modify.ajx")
    public Map<String,Object> modifyAjax(Users user,@RequestParam(required = false) MultipartFile mf,HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            if(mf != null){
                filesService.updateIsUse(loginUser.getFileNo());
                Map<String,Object> map = filesService.uploadFile(mf,1);
                Files file = new Files(0,
                        (String)map.get("saveName"),
                        (String)map.get("originalName"),
                        (String)map.get("filePath"),
                        (String)map.get("fileExt"),
                        "Y",
                        user.getUId(),
                        0,0,0,
                        (Long)map.get("fileSize"));
                filesService.createFile(file,1);
                int fileNo = filesService.findCurFileNo();
                user.setFileNo(fileNo);
            }
            int result = usersService.updateUser(user);
            if(result == 1){
                code = 1;
                forwardPath = "/user/detail?uId="+user.getUId();
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //8. 회원탈퇴
    @GetMapping("/withdrawal.action")
    public String deleteAction(HttpSession session){
        String forwardPath="";
        try{
            Users user = (Users) session.getAttribute("loginUser");
            forwardPath = "/user/logout.action";
            int result = usersService.withdrawalUser(user.getUId(),99);
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //9. 내가 쓴 게시글 보기
    @GetMapping(value = "/boardList")
    public String myBoardList(@RequestParam String uId, HttpSession session,Model model){
        String forwardPath="";
        try{
            Users users = (Users)session.getAttribute("loginUser");
            List<Board> boardList = boardService.findBoardByUId(users.getUId());
            model.addAttribute("boardList",boardList);
            forwardPath="/user/boardList";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //10. 내가 지원&참여한 모임 보기
    @GetMapping(value="applyList")
    public String myApplyList(@RequestParam String uId,Model model){
        String forwardPath = "";
        try{
            List<Apply> applyList = applyService.findApplyByUId(uId);
            List<Gathering> gatheringList = new ArrayList<>();
            for(int i=0;i<applyList.size();i++){
                Apply apply = applyList.get(i);
                Gathering gathering = gatheringService.findGathByNo(apply.getGathNo());
                gatheringList.add(gathering);
            }
            model.addAttribute("gatheringList",gatheringList);
            model.addAttribute("applyList",applyList);
            forwardPath="/user/applyList";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //11. 내가 개설한 모임 보기
    @GetMapping(value = "/gatheringList")
    public String myGathRegisterList(@RequestParam String uId,Model model){
        String forwardPath ="";
        try{
            List<Gathering> gatheringList = gatheringService.findGathByUId(uId);
            model.addAttribute("gatheringList",gatheringList);
            forwardPath="/user/gatheringList";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //12. 회원리스트
    @GetMapping(value = "/list")
    public String listPage(Model model,
                           @RequestParam(required = false, defaultValue = "1") int pageNo,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String filterType,
                           @RequestParam(required = false) String ascDesc){
        String forwardPath = "";
        try{
            SearchDto<Users> searchUserList = usersService.findSearchedUserList(pageNo,keyword,filterType,ascDesc);
            model.addAttribute("searchUserList",searchUserList);
            forwardPath = "/user/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //12-1. 회원리스트 AJAX
    @ResponseBody
    @PostMapping("list.ajx")
    public Map<String,Object> listAjax(@RequestParam(required = false, defaultValue = "1") int pageNo,
                                       @RequestParam(required = false) String keyword,
                                       @RequestParam(required = false) String filterType,
                                       @RequestParam(required = false) String ascDesc){
        Map<String,Object> resultMap = new HashMap<>();
        try{
            resultMap.put("pageNo",pageNo);
            resultMap.put("keyword",keyword);
            resultMap.put("filterType",filterType);
            resultMap.put("ascDesc",ascDesc);
        } catch (Exception e){
            e.printStackTrace();
        }
        return resultMap;

    }



}
