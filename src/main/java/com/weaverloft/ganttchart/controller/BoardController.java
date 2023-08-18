package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.FileService;
import com.weaverloft.ganttchart.Service.BoardFileService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.BoardFile;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BoardController {
    private BoardService boardService;
    private BoardFileService boardFileService;
    private FileService fileService;

    public BoardController(BoardService boardService, BoardFileService boardFileService, FileService fileService) {
        this.boardService = boardService;
        this.boardFileService = boardFileService;
        this.fileService = fileService;
    }

    //1. 게시글 전체보기
    @GetMapping(value="/boardList/{pageNo}")
    public ModelAndView boardList(@PathVariable int pageNo,
                                  @RequestParam(required = false) String keyword,
                                  HttpSession session,
                                  ModelAndView mv) throws Exception{
        try{
            System.out.println(pageNo);
            PageMakerDto<Board> boardListPage = boardService.findBoardList(pageNo,keyword);
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
            Board board = boardService.findByBoardNo(boardNo);
            List<BoardFile> boardFileList = boardFileService.findByBoardNo(boardNo);
            if(board!=null){
                mv.addObject("board", board);
                mv.addObject("boardFileList",boardFileList);
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
    public ModelAndView boardCreateAction(@ModelAttribute Board board, MultipartHttpServletRequest mf, HttpSession session, ModelAndView mv){
        List<MultipartFile> boardFileList = mf.getFiles("boardFileList");
        System.out.println("boardFileList = " + boardFileList);
        Users loginUser=(Users)session.getAttribute("loginUser");
        board.setId(loginUser.getId());
        try{
            int result = boardService.createBoard(board);
            int boardNo = boardService.findCurKey();
            System.out.println("boardNo = " + boardNo);
            String filePath = "C:\\temp\\upload\\board\\";
            for(MultipartFile boardFile : boardFileList){
                String fileName = fileService.uploadFile(boardFile,filePath);
                System.out.println("fileName = " + fileName);
                BoardFile file = new BoardFile(0,fileName,boardNo);
                boardFileService.createBoardFile(file);
            }
            mv.setViewName("redirect:/boardList");
        } catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
}
