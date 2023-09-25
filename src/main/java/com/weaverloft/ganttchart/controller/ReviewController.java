package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.GatheringService;
import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.Service.ReviewService;
import com.weaverloft.ganttchart.dto.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/gathering/review/*")
public class ReviewController {
    private ReviewService reviewService;
    private GatheringService gatheringService;
    private MenuService menuService;

    public ReviewController(ReviewService reviewService,GatheringService gatheringService,MenuService menuService) {
        this.reviewService = reviewService;
        this.gatheringService = gatheringService;
        this.menuService = menuService;
    }

    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        System.out.println("menuList = " + menuList);
        return menuList;
    }

    //1.리뷰작성 페이지
    @GetMapping(value = "/register")
    public String createReviewPage(@RequestParam int gathNo,Model model){
        String forwardPath = "";
        try{
            Gathering gathering = gatheringService.findGathByNo(gathNo);
            System.out.println("gathering = " + gathering);
            model.addAttribute("gathering",gathering);
            forwardPath = "/gathering/review/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1. 리뷰작성 ajx
    @ResponseBody
    @PostMapping("/register.ajx")
    public Map<String, Object> createReviewAjax(HttpSession session, Model model, Review review, @RequestPart(required = false) List<Files> fileList){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            review.setUId(loginUser.getUId());
            review.setFileList(fileList);
            int result = reviewService.createReview(review);
            if(result == 1){
                code = 1;
                msg = "작성하신 리뷰를 확인하시겠습니까";   //알림창(confirm) 띄워서 해당페이지에 있기(false), 모임디테일페이지로 가기(true) 선택 주기
                forwardPath = "/gathering/detail?gathNo="+review.getGathNo();
            } else{
                code = 2;
                msg ="이야이야오";
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }






}
