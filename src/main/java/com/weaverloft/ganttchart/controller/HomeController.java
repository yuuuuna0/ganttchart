package com.weaverloft.ganttchart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    //시작 페이지
    public String index(){
        return "login";
    }

    @GetMapping("/error")
    public String eroror(){
        return "error";
    }
}
