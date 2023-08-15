package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {
    private BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }
    //1. 게시글 전체보기
    @GetMapping("boardList")
    public ModelAndView boardList(@RequestParam(required = false, defaultValue = "1") int pageNo,
                                  @RequestParam(required = false) String keyword,
                                  HttpSession session,
                                  ModelAndView mv) throws Exception{
        try{
            PageMakerDto<Board> boardListPage = boardService.selectBoardList(pageNo,keyword);
            mv.addObject("boardListPage",boardListPage);
            mv.setViewName("boardList");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //2. 게시글 상세보기
    @GetMapping(value="board")
    public ModelAndView boardDetail(ModelAndView mv) throws Exception{
        int boardNo=81;
        try {
            Board board = boardService.selectByBoardNo(boardNo);
            if(board!=null){
                mv.addObject("board", board);
                mv.setViewName("board");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    //3. 게시글 작성하기 페이지
    @LoginCheck
    @GetMapping("boardCreate")
    public String boardCreate(){
        return "boardCreate";
    }
    //3-1 게시글 작성하기 액션
    @LoginCheck
    @PostMapping("boardCreate-action")
    public ModelAndView boardCreateAction(@RequestParam Map map, ModelAndView mv,HttpSession session){
        String boardTitle=(String)map.get("boardTitle");
        String boardContent=(String)map.get("boardContent");
        Users loginUser=(Users)session.getAttribute("loginUser");
        List<String> fileList=new ArrayList<>();
        try{
            Board board=new Board(0,boardTitle,boardContent,new Date(),fileList,loginUser.getId(),0);
            int result=boardService.createBoard(board);
            mv.setViewName("redirect:boardList");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
}
