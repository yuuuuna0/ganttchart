package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.apache.ibatis.logging.stdout.StdOutImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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
    @GetMapping(value="board", params="boardNo")
    public ModelAndView boardDetail(@RequestParam int boardNo, ModelAndView mv) throws Exception{
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
    @GetMapping("createBoard")
    public String createBoard(){
        return "boardCreate";
    }
    //3-1 게시글 작성하기 액션
    //@PostMapping("")
}
