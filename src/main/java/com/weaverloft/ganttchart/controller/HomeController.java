package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.FileService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.dto.UsersLog;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
public class HomeController {
    FileService fileService;
    BoardService boardService;

    public HomeController(FileService fileService,BoardService boardService) {
        this.fileService = fileService;
        this.boardService=boardService;
    }

//    @GetMapping("/")
//    //시작 페이지
//    public String index(Model model) {
//        String forwardPath="";
//        try{
//            //조회수 탑5 게시글 붙이기
//            int no = 5;
//            List<Board> boardTopList = boardService.findBoardTopList(no);
//            model.addAttribute("boardTopList", boardTopList);
//            forwardPath = "index";
//        } catch (Exception e){
//            e.printStackTrace();
//        }
//        return forwardPath;
//    }

    @GetMapping("/error")
    public String error(){
        return "/error";
    }



    /***************************************************************************************/
    private Logger logger = LoggerFactory.getLogger(HomeController.class);

    //간단하게 메인페이지로 돌아오게 하기
    @GetMapping("/")
    public String home(Locale locale,Model model){
        logger.info("메인페이지, client의 locale: "+locale);
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,DateFormat.LONG,locale);
        String formattedDate = dateFormat.format(date);

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String id = null;
        String password = null;

        try{
            Users users = (Users)principal;
            id = users.getId();
            password = users.getPassword();
        } catch (Exception e){
            e.printStackTrace();
        }
        model.addAttribute("id",id);
        model.addAttribute("password",password);
        model.addAttribute("serverTime",formattedDate);
     return "index";
    }



}
