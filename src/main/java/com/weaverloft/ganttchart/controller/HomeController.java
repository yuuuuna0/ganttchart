package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.CommentsService;
import com.weaverloft.ganttchart.Service.FileService;
import com.weaverloft.ganttchart.Service.MenuService;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {
    FileService fileService;
    BoardService boardService;
    MenuService menuService;
    CommentsService commentsService;

    public HomeController(FileService fileService,BoardService boardService,MenuService menuService,CommentsService commentsService) {
        this.fileService = fileService;
        this.boardService=boardService;
        this.menuService = menuService;
        this.commentsService = commentsService;
    }

    @GetMapping("/")
    //시작 페이지
    public String index(Model model) {
        String forward = "";
        String keyword =null;
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList",map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            //조회수 탑5 게시글 붙이기
            int no = 5;
            List<Board> boardTopList = boardService.findBoardTopList(no);
            model.addAttribute("boardTopList", boardTopList);
            forward = "index";
        } catch (Exception e){
            e.printStackTrace();
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
