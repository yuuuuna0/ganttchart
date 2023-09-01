package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.xml.stream.events.Comment;
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class HomeController {
    FileService fileService;
    BoardService boardService;
    MenuService menuService;
    CommentsService commentsService;
    UsersLogService usersLogService;

    public HomeController(FileService fileService,BoardService boardService,MenuService menuService,CommentsService commentsService,
                          UsersLogService usersLogService) {
        this.fileService = fileService;
        this.boardService=boardService;
        this.menuService = menuService;
        this.commentsService = commentsService;
        this.usersLogService = usersLogService;
    }

    @GetMapping("/")
    //시작 페이지
    public String login() {
        String forward = "";
        String keyword =null;
        try{
            forward = "redirect:/login";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forward;
    }
    @GetMapping("/index")
    //시작 페이지
    public String index(Model model) {
        String forward = "";
        String keyword =null;
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList",map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            //차트 붙이기
                //1) 날짜리스트 붙이기
            List<String> dateList = new ArrayList<>();
            List<Integer> visitorCountList = new ArrayList<>();
            List<Integer> newUserCountList = new ArrayList<>();
            List<Integer> newBoardCountList = new ArrayList<>();
            for(int i=0;i<7;i++){
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.DAY_OF_MONTH,-(6-i));
                visitorCountList.add(usersLogService.countPersonPerDay(10,calendar.getTime()));
                newUserCountList.add(usersLogService.countPersonPerDay(0,calendar.getTime()));
                newBoardCountList.add(boardService.countNewBoardPerDay(calendar.getTime())); //보드서비스
                SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd.");
                dateList.add("'"+format.format(calendar.getTime())+"'");
            }
            System.out.println("newUserCountList = " + newUserCountList);
            model.addAttribute("dateList",dateList);
            model.addAttribute("visitorCountList",visitorCountList);
            model.addAttribute("newUserCountList",newUserCountList);
            model.addAttribute("newBoardCountList",newBoardCountList);

           //조회수 탑5 게시글 붙이기
            int no = 5;
            List<Board> boardTopList = boardService.findBoardTopList(no);
            model.addAttribute("boardTopList", boardTopList);
            forward = "/index";
        } catch (Exception e){
            e.printStackTrace();
            forward = "/error";
        }
        return forward;
    }

    @GetMapping("/error")
    public String error(Model model){
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList",map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }

        return "/error";
    }



}
