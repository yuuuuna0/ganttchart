package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.CommentsService;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/board/comment/*")
public class CommentController {
    private CommentsService commentsService;
    private BoardService boardService;

    public CommentController(CommentsService commentsService, BoardService boardService) {
        this.commentsService = commentsService;
        this.boardService = boardService;
    }

    //1. 댓글 남기기 -> 1) 부모댓글(depth:1) 2) 자식댓글
    @PostMapping("/create.ajx")
    public Map<String,Object> createComment(Comments comments, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        Users loginUser = (Users) session.getAttribute("loginUser");
        try{
            comments.setUId(loginUser.getUId());
            int result = 0;
            if(comments.getDepth() == 0){
                result = commentsService.createPreComment(comments);
            } else {
                if(commentsService.findSameOrders(comments.getOrders(),comments.getBoardNo(),comments.getGroupNo()) !=null){
                    commentsService.changeOrders(comments.getOrders(),comments.getBoardNo());
                }

                result = commentsService.createSubComment(comments);
            }
            if(result == 1){
                List<Comments> commentList = commentsService.findCommentByBoardNo(comments.getBoardNo());
                List<Comments> preCommentList = commentsService.findPreCommentByBoardNo(comments.getBoardNo());
                code =1;
                resultMap.put("commentList",commentList);
                resultMap.put("preCommentList",preCommentList);
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("user",loginUser);
        return resultMap;
    }

}
