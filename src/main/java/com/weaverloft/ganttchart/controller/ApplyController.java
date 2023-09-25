package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.ApplyService;
import com.weaverloft.ganttchart.dto.Apply;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/gathering/apply/*")
public class ApplyController {
    private ApplyService applyService;

    public ApplyController(ApplyService applyService) {
        this.applyService = applyService;
    }


    //1. 모임 신청여부 변경하기
    @ResponseBody
    @PostMapping(value = "/change.ajx")  //리턴타입 void?
    public Map<String,Object> changeApply( Apply apply){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        int countAcceptedApply =0;
        try{
            int result = applyService.changeApplyStatusNo(apply.getApplyNo(),apply.getApplyStatusNo());
            countAcceptedApply = applyService.countAcceptedApply(apply.getGathNo());
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        resultMap.put("accpetedPerson",countAcceptedApply);
        return resultMap;
    }



}
