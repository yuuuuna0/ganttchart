package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.CommentsService;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class CommentsController {

    private CommentsService commentsService;

    public CommentsController(CommentsService commentsService) {
        this.commentsService = commentsService;
    }

    //1. 해당 게시글 댓글 조회
    @ResponseBody
    @PostMapping("/findComments-ajax")
    public Map<String,Object> findCommentsByBoardNoAjax(int boardNo, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        String forwardPath="";
        Users loginUser = (Users)session.getAttribute("loginUser");
        try{
            List<Comments> commentList = commentsService.findCommentsByBoardNo(boardNo);
        } catch (Exception e){
            e.printStackTrace();
        }
      return resultMap;
    }

    //2. 댓글 남기기
    @LoginCheck
    @ResponseBody
    @PostMapping("/createComments-ajax")
    public Map<String,Object> createCommentsAjax(@RequestParam Map<String,Object> map, Model model, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 1 ; //1:성공 2: 실패
        String msg = "성공";
        String forwardPath ="";
        List<Comments> data = new ArrayList<>();
        Users loginUser = (Users)session.getAttribute("loginUser");
        try{
            String commentsContent = (String)map.get("commentsContent");
            int groupNo=0;
            int orders=Integer.parseInt(map.get("orders").toString());
            int boardNo = Integer.parseInt(map.get("boardNo").toString());
            if(orders == 0){
                //1) 상위댓글일 때 ->  groupNo = commentsNo
                //groupNo 어떻게?
                Comments comments = new Comments(0,commentsContent,new Date(),orders,groupNo,boardNo,loginUser.getId());
                int result = commentsService.createComments(comments);
                int curKey = commentsService.findCurCommentsNo();
                int updateResult = commentsService.updateGroupNo(curKey);
            } else{
                //2) 하위댓글일 때 ->  groupNo = 상위댓글의 commentsNo
                groupNo = Integer.parseInt(map.get("commentsNo").toString());
                orders = commentsService.findCommentsCountByGroupNo(groupNo);
                Comments comments = new Comments(0,commentsContent,new Date(),orders,groupNo,boardNo,loginUser.getId());
                int result = commentsService.createComments(comments);
                int updateResult = commentsService.updateGroupNo(groupNo);
            }
            List<Comments> commentsList = commentsService.findCommentsByBoardNo(boardNo);
            data = commentsList;
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "댓글 남기기 실패";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("data",data);
        resultMap.put("loginUser",loginUser);
        return resultMap;
    }

    //3. 댓글 삭제
    @LoginCheck
    @ResponseBody
    @PostMapping("/deleteComment-ajax")
    public Map<String,Object> deleteCommentAjax(@RequestParam Map<String,Object> map,HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int commentsNo = Integer.parseInt(map.get("commentsNo").toString());
        int boardNo = Integer.parseInt(map.get("boardNo").toString());
        int code = 1;
        String msg = "성공";
        List<Comments> data = new ArrayList<>();
        Users loginUser = (Users)session.getAttribute("loginUser");
        try{
            int result = commentsService.deleteComments(commentsNo);
            List<Comments> commentsList = commentsService.findCommentsByBoardNo(boardNo);
            data = commentsList;
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "실패";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("data",data);
        resultMap.put("loginUser",loginUser);
        return resultMap;
    }

    //4. 댓글 수정하기
    @LoginCheck
    @ResponseBody
    @PostMapping("/modifyComment-ajax")
    public Map<String,Object> modifyCommentAjax(@RequestParam Map<String,Object> map,HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 1;
        String msg = "";
        List<Comments> data = new ArrayList<>();
        int commentsNo = Integer.parseInt(map.get("commentsNo").toString());
        int boardNo = Integer.parseInt(map.get("boardNo").toString());
        String commentsContent = (String)map.get("commentsContent");
        Users loginUser = (Users)session.getAttribute("loginUser");
        try{
            int result = commentsService.updateComments(commentsNo,commentsContent);
            List<Comments> commentsList = commentsService.findCommentsByBoardNo(boardNo);
            data = commentsList;
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "실패";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("data",data);
        resultMap.put("loginUser",loginUser);
        return resultMap;
    }
}
