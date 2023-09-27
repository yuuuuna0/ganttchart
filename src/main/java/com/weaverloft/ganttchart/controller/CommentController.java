package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.CommentsService;
import com.weaverloft.ganttchart.controller.annotation.LoginCheck;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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
    @LoginCheck
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
                if(commentsService.findSameOrders(comments) != 0){
                    //orders 순서 하나씩 증가시켜주기 --> 동일 depth면 order 그 밑으로 가야하는데 이거 어케할겨?
                    int orders = commentsService.findSameDepth(comments);
                    comments.setOrders(orders);
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
        resultMap.put("loginUser",loginUser);
        return resultMap;
    }
    //2. 댓글 수정하기
    @LoginCheck
    @PostMapping(value = "modify.ajx",params = "commentsNo")
    public Map<String,Object> modifyAjax(Comments comments, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        Users loginUser = (Users) session.getAttribute("loginUser");
        try{
            int result = commentsService.updateComment(comments);
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
        resultMap.put("loginUser",loginUser);
        return resultMap;
    }
    //3. 댓긇 삭제하기
    @LoginCheck
    @PostMapping(value = "/delete.ajx", params = "commentsNo")
    public Map<String,Object> deleteAjax(int commentsNo,int boardNo,HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        Users loginUser = (Users) session.getAttribute("loginUser");
        try{
            int result = commentsService.deleteCommentByNo(commentsNo);
            if(result == 1){
                List<Comments> commentList = commentsService.findCommentByBoardNo(boardNo);
                List<Comments> preCommentList = commentsService.findPreCommentByBoardNo(boardNo);
                code =1;
                resultMap.put("commentList",commentList);
                resultMap.put("preCommentList",preCommentList);
            }
        }catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("loginUser",loginUser);
        return resultMap;
    }
}
