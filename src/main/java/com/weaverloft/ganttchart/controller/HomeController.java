package com.weaverloft.ganttchart.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    //공통으로 붙이는 부분에 대해 어떻게 분리시킬 것인지 생각해야함

    //1. 메인페이지
    @GetMapping("/")
    public String indexPage(){
        String forwardPath ="";
        try{
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
