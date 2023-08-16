package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

@Controller
public class BoardController {
    private BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }
    //1. 게시글 전체보기
    @RequestMapping("boardList")
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
        int boardNo=201;
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
    @GetMapping("boardCreate")
    public String boardCreate(){
        return "boardCreate";
    }
    //3-1 게시글 작성하기 액션
    @RequestMapping("boardCreate-action")
    public ModelAndView boardCreateAction(@RequestBody Map map, ModelAndView mv, HttpSession session){
        String boardTitle=(String)map.get("boardTitle");
        String boardContent=(String)map.get("boardContent");
        Users loginUser=(Users)session.getAttribute("loginUser");
        try{
            Board createBoard=new Board(0,boardTitle,boardContent,new Date(),loginUser.getId(),0);
            System.out.println(createBoard);
            int result=boardService.createBoard(createBoard);
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
}
