package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.FileService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
    public String index(){
        return "index";
    }

    @GetMapping("/error")
    public String error(){
        return "error";
    }

//    @GetMapping("image")
//    public String image(){
//        return "image";
//    }
//
//    @PostMapping("image-action")
//    public void test(MultipartHttpServletRequest multiRequest) throws Exception{
//        String result=fileService.uploadFile(multiRequest);
//        System.out.println(result);
//    }


}
