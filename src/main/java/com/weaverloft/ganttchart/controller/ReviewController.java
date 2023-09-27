package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.FilesService;
import com.weaverloft.ganttchart.Service.GatheringService;
import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.Service.ReviewService;
import com.weaverloft.ganttchart.controller.annotation.LoginCheck;
import com.weaverloft.ganttchart.dto.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    private FilesService filesService;

    public ReviewController(ReviewService reviewService,GatheringService gatheringService,MenuService menuService,FilesService filesService) {
        this.reviewService = reviewService;
        this.gatheringService = gatheringService;
        this.menuService = menuService;
        this.filesService = filesService;
    }

    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        System.out.println("menuList = " + menuList);
        return menuList;
    }

    //1.리뷰작성 페이지
    @LoginCheck
    @GetMapping(value = "/register")
    public String createReviewPage(@RequestParam int gathNo,Model model){
        String forwardPath = "";
        try{
            Gathering gathering = gatheringService.findGathByNo(gathNo);
            model.addAttribute("gathering",gathering);
            forwardPath = "/gathering/review/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1. 리뷰작성 ajx
    @LoginCheck
    @ResponseBody
    @PostMapping("/register.ajx")
    public Map<String, Object> createReviewAjax(HttpSession session, Model model, Review review, @RequestPart(required = false) List<MultipartFile> mfList){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            review.setUId(loginUser.getUId());
            int result = reviewService.createReview(review);
            int reviewNo = reviewService.findCurNo();
            if(mfList != null) {
                for (int i = 0; i < mfList.size(); i++) {
                    MultipartFile mf = mfList.get(i);
                    Map<String, Object> map = filesService.uploadFile(mf, 3);
                    Files file = new Files(0,
                            (String) map.get("saveName"),
                            (String) map.get("originalName"),
                            (String) map.get("filePath"),
                            (String) map.get("fileExt"),
                            "Y",
                            null,
                            0, reviewNo, 0,
                            (Long) map.get("fileSize"));
                    filesService.createFile(file, 3);
                }
            }
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

    //2. 리뷰 수정하기
    @LoginCheck
    @GetMapping(value = "/modify")
    public String modifyReviewPage(@RequestParam int reviewNo,Model model){
        String forwardPath = "";
        try{
            Review review = reviewService.findReviewByReviewNo(reviewNo);
            Gathering gathering = gatheringService.findGathByNo(review.getGathNo());
            model.addAttribute("gathering",gathering);
            forwardPath = "/gathering/review/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }






}
