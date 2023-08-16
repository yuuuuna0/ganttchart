package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
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
    @GetMapping("/boardDetail/{boardNo}")
    public ModelAndView boardDetail(@PathVariable int boardNo,ModelAndView mv) throws Exception{
        try {
            int result = boardService.updateBoardReadcount(boardNo);
            Board board = boardService.selectByBoardNo(boardNo);
            if(board!=null){
                mv.addObject("board", board);
                mv.setViewName("boardDetail");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }

    //3. 게시글 작성하기 페이지
    @GetMapping("boardWrite")
    public String boardCreate(){
        return "boardWrite";
    }
    //3-1 게시글 작성하기 액션
    @PostMapping("/boardWrite-action")
    public ModelAndView boardCreateAction(@ModelAttribute Board board, MultipartFile multipartFile, ModelAndView mv,HttpSession session){
        MultipartFile boardFile =multipartFile;
        Users loginUser=(Users)session.getAttribute("loginUser");
        board.setId(loginUser.getId());
        try{
            int result = boardService.createBoard(board);
            mv.setViewName("redirect:/boardList");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
}
