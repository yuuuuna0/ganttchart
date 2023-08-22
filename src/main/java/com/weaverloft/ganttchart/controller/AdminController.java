package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.UsersLogService;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class AdminController {
    private UsersService usersService;
    private UsersLogService usersLogService;

    public AdminController(UsersService usersService,UsersLogService usersLogService) {
        this.usersService = usersService;
        this.usersLogService = usersLogService;
    }

    //1. 회원리스트 출력
    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/userList/{pageNo}")
    public ModelAndView userList(@PathVariable int pageNo,
                                 @RequestParam(required = false) String keyword,
                                 HttpSession session,
                                 ModelAndView mv){
        try{
            PageMakerDto userListPage = usersService.findUserList(pageNo,keyword);
            mv.addObject("userListPage",userListPage);
            mv.setViewName("admin/userList");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //2. 회원 로그 출력
    @Secured("ROLE_ADMIN")
    @GetMapping("/admin/userLog/{pageNo}")
    public ModelAndView userLog(@PathVariable int pageNo,
                                @RequestParam(required = false) String keyword,
                                HttpSession session,
                                ModelAndView mv){
        try{
            PageMakerDto usersLogPage = usersLogService.findUserLog(pageNo,keyword);
            mv.addObject("usersLogPage",usersLogPage);
            mv.setViewName("admin/userLog");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //3. 메뉴리스트 출력

    //4. 메뉴만들기 페이지

    //4-1. 메뉴만들기 액션

    //4-2. 메뉴 상세보기

    //4-3. 메뉴 수정하기

    //5. 메뉴 삭제
}
