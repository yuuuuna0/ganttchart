package com.weaverloft.ganttchart.controller;


import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Gathering;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
public class HomeController {
    private UsersService usersService;
    private MenuService menuService;
    private BoardService boardService;
    private GatheringService gatheringService;
    public HomeController(UsersService usersService,MenuService menuService,BoardService boardService,GatheringService gatheringService) {
        this.usersService = usersService;
        this.menuService = menuService;
        this.boardService = boardService;
        this.gatheringService = gatheringService;
    }

    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        return menuList;
    }

    //1. 메인페이지
    @GetMapping("/")
    public String indexPage(Model model, HttpSession session){
        String forwardPath ="";
        try{
            Users loginUser = (Users)session.getAttribute("loginuser");
            Users users = usersService.findUserById("admin");
            List<Board> topNboardList = boardService.findTopNBoard(5);
            List<Gathering> topNGathList = gatheringService.findTopNGath(5);
            List<Gathering> nearGathList = gatheringService.findNearGath();
            model.addAttribute("topNboardList",topNboardList);
            model.addAttribute("topNGathList",topNGathList);
            model.addAttribute("nearGathList",nearGathList);
            //차트붙이기
            //차트 붙이기
            //1) 날짜리스트 붙이기
            List<String> dateList = new ArrayList<>();
            List<Integer> newApplyCountList = new ArrayList<>();
            List<Integer> newUserCountList = new ArrayList<>();
            List<Integer> newBoardCountList = new ArrayList<>();
//            for(int i=0;i<7;i++){
//                Calendar calendar = Calendar.getInstance();
//                calendar.add(Calendar.DAY_OF_MONTH,-(6-i));
//                newApplyCountList.add(allLogService.newApplyCountList(,calendar.getTime()));
//                newUserCountList.add(allLogService.countPersonPerDay(1,calendar.getTime()));
//                newBoardCountList.add(boardService.countNewBoardPerDay(calendar.getTime())); //보드서비스
//                SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd.");
//                dateList.add("'"+format.format(calendar.getTime())+"'");
//            }
//            System.out.println("newUserCountList = " + newUserCountList);
//            model.addAttribute("dateList",dateList);
//            model.addAttribute("visitorCountList",visitorCountList);
//            model.addAttribute("newUserCountList",newUserCountList);
//            model.addAttribute("newBoardCountList",newBoardCountList);


            forwardPath="/index";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //2. 에러페이지
    @GetMapping("/error")
    public String errorPage(){
        String forwardPath ="";
        try{
            forwardPath="/error";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 접근불가 페이지
    @GetMapping("/accessError")
    public void accssDenied(Authentication auth,Model model) {
        System.out.println("auth = " + auth);
        model.addAttribute("msg", "접근할 수 없는 페이지입니다.");
    }
}
