package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.ApplyService;
import com.weaverloft.ganttchart.dto.Apply;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/gathering/apply/*")
public class ApplyController {
    private ApplyService applyService;

    public ApplyController(ApplyService applyService) {
        this.applyService = applyService;
    }

    //1. 모임 신청여부 변경하기
    @PostMapping(value = "/change.ajx")  //리턴타입 void?
    public Map<String,Object> changeApply(@RequestParam int applyNo, Apply apply){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        try{
            int result = applyService.changeApplyStatusNo(applyNo,apply.getApplyStatusNo());
            int countAcceptedApply = applyService.countAcceptedApply(apply.getGathNo());
//            if() --> 수락인원 비교해서 인원마감상태로 변경해야함
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
