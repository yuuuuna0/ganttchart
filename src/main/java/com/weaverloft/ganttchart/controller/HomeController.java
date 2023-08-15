package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.FileService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class HomeController {
    FileService fileService;
    BoardService boardService;

    public HomeController(FileService fileService,BoardService boardService) {
        this.fileService = fileService;
        this.boardService=boardService;
    }

    @GetMapping("/")
    //시작 페이지
    public ModelAndView index(ModelAndView mv) throws Exception{
        int pageNo=1;
        String keyword =null;
        try{
            PageMakerDto<Board> boardListPage = boardService.selectBoardList(pageNo,keyword);
            mv.addObject("boardListPage", boardListPage);
            mv.setViewName("index");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    @GetMapping("/error")
    public String error(){
        return "error";
    }




}
