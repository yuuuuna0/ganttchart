package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.dto.Board;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
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
    public ModelAndView boardList(@RequestParam Map map){
        ModelAndView mv = new ModelAndView();
        List<Board> boardList=new ArrayList<Board>();
        try{
            boardList=boardService.selectBoardList();
            mv.addObject("boardList",boardList);
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
