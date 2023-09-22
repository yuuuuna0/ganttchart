package com.weaverloft.ganttchart.controller;


import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.GatheringService;
import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Gathering;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {
    private MenuService menuService;
    private BoardService boardService;
    private GatheringService gatheringService;
    public HomeController(MenuService menuService,BoardService boardService,GatheringService gatheringService) {
        this.menuService = menuService;
        this.boardService = boardService;
        this.gatheringService = gatheringService;
    }

    //공통으로 붙이는 부분에 대해 어떻게 분리시킬 것인지 생각해야함

    //1. 메인페이지
    @GetMapping("/")
    public String indexPage(Model model, HttpSession session){
        String forwardPath ="";
        try{
            Users loginUser = (Users)session.getAttribute("loginuser");
            /*********************공통 메뉴부분 -> 분리 필요한 부분**********************************/
            List<Menu> menuList = menuService.findUserMenuList();
            if(loginUser != null) {
                switch (loginUser.getUTypeNo()) {
                    case 0:
                        menuList = menuService.findAdminMenuList();
                        break;
                    case 1:
                        menuList = menuService.findUserMenuList();
                        break;
                    case 2:
                        menuList = menuService.findSellerMenuList();
                        break;
                }
            }
            model.addAttribute("menuList",menuList);
            /*************************************************************/
            List<Board> topNboardList = boardService.findTopNBoard(5);
            List<Gathering> topNGathList = gatheringService.findTopNGath(5);
            List<Gathering> nearGathList = gatheringService.findNearGath();
            model.addAttribute("topNboardList",topNboardList);
            model.addAttribute("topNGathList",topNGathList);
            model.addAttribute("nearGathList",nearGathList);


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

        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 파일 다운로드 --> 파일 다운로드 구현해야함
    @PostMapping(value = "/download")
    public void downloadFile(@RequestParam int fileNo){

    }

//    @GetMapping("/user/register")
//    public String registerPage(){
//        String forwardPath = "";
//        try{
//            forwardPath = "/user/register";
//        } catch (Exception e){
//            e.printStackTrace();
//        }
//        return forwardPath;
//    }

}
