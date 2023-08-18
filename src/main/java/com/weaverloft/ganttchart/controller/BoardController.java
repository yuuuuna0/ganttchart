package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.FileService;
import com.weaverloft.ganttchart.Service.BoardFileService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.BoardFile;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @GetMapping("/boardList/{pageNo}")
    public String boardList(@PathVariable int pageNo,
                            @RequestParam(required = false) String keyword,
                            Model model,HttpSession session) {
        String forwardPath;
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            PageMakerDto<Board> boardListPage = boardService.findBoardList(pageNo,keyword);
            model.addAttribute("boardListPage",boardListPage);
            model.addAttribute("loginUser",loginUser);
            forwardPath="/boardList";
        } catch (Exception e){
            e.printStackTrace();
            forwardPath="error";
        }
        return forwardPath;
    }
    //2. 게시글 검색하기, 조회수, 작성일 오름차순 내림차순 적용
    @ResponseBody
    @PostMapping("/boardList")
    public Map<String,Object> searchBoardList(){
        Map<String,Object> resultMap = new HashMap<>();

        return resultMap;
    }
//    //1-1. 게시글 전체보기 --> ajax 적용
//    @ResponseBody   //Http 응답의 body로 사용될 객체를 반환
//    @PostMapping(value="/boardList-ajax")
//    public Map<String,Object> boardListAjax(@RequestParam Map<String,Object> map, Model model,HttpSession session){
//        Map<String,Object> resultMap = new HashMap<>();
//        int code = 1; // 1:성공 2: 실패
//        String msg = "성공";
//        PageMakerDto<Board> data = null;
//        try{
//            int pageNo =  Integer.parseInt(map.get("pageNo").toString());
//            String keyword=null;
//            if(map.get("keyword") != null){
//                keyword = map.get("keyword").toString();
//            } else{
//                keyword=null;
//            }
//            Users loginUser = (Users)session.getAttribute("loginUser");
//            PageMakerDto<Board> boardListPage = boardService.findBoardList(pageNo,keyword);
//            data = boardListPage;
//            code = 1;
//        } catch (Exception e){
//            e.printStackTrace();
//            code =2;
//            msg = "관리자에게 문의하세요";
//        }
//        resultMap.put("code",code);
//        resultMap.put("msg",msg);
//        resultMap.put("data",data);
//        return resultMap;
//    }

    //2. 게시글 상세보기
    @GetMapping("/boardDetail/{boardNo}")
    public ModelAndView boardDetail(@PathVariable int boardNo,ModelAndView mv) {
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
