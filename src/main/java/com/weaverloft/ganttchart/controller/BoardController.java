package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.CommentsService;
import com.weaverloft.ganttchart.Service.FileService;
import com.weaverloft.ganttchart.Service.BoardFileService;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.BoardFile;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/board/*")
public class BoardController {
    private BoardService boardService;
    private BoardFileService boardFileService;
    private FileService fileService;
    private CommentsService commentsService;

    public BoardController(BoardService boardService, BoardFileService boardFileService, FileService fileService, CommentsService commentsService) {
        this.boardService = boardService;
        this.boardFileService = boardFileService;
        this.fileService = fileService;
        this.commentsService = commentsService;
    }

    //1. 게시글 전체보기
    @GetMapping("/list/{pageNo}")
    public String boardList(@PathVariable int pageNo,
                            @RequestParam(required = false) String keyword,
                            Model model,HttpSession session) {
        String forwardPath;
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            PageMakerDto<Board> boardListPage = boardService.findBoardList(pageNo,keyword);
//            model.addAttribute("boardCommentCount",boardCommentCount);
            model.addAttribute("boardListPage",boardListPage);
//            model.addAttribute("loginUser",loginUser);
            forwardPath="/board/list";
        } catch (Exception e){
            e.printStackTrace();
            forwardPath="error";
        }
        return forwardPath;
    }
//    //2. 게시글 검색하기, 조회수, 작성일 오름차순 내림차순 적용
//    @ResponseBody
//    @PostMapping("/list/{pageNo}")
//    public Map<String,Object> searchBoardList(){
//        Map<String,Object> resultMap = new HashMap<>();
//
//        return resultMap;
//    }
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
    @GetMapping("/detail/{boardNo}")
    public String boardDetail(@PathVariable int boardNo,Model model) {
        String forwardPath = "";
        try {
            int result = boardService.updateBoardReadcount(boardNo);
            Board board = boardService.findByBoardNo(boardNo);
            List<BoardFile> boardFileList = boardFileService.findByBoardNo(boardNo);
            List<Comments> commentsList = commentsService.findCommentsByBoardNo(boardNo);
            if(board!=null){
                model.addAttribute("board", board);
                model.addAttribute("boardFileList",boardFileList);
                model.addAttribute("commentsList", commentsList);
                forwardPath ="/board/detail";
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 게시글 작성하기 페이지
    @LoginCheck
    @GetMapping("/register")
    public String boardCreate(){
        return "board/register";
    }
    //3-1 게시글 작성하기 액션
    @LoginCheck
    @PostMapping("/register-action")
    public String boardCreateAction(@ModelAttribute Board board, MultipartHttpServletRequest mf, HttpSession session){
        String forwardPath = "";
        Users loginUser=(Users)session.getAttribute("loginUser");
        List<MultipartFile> boardFileList = mf.getFiles("boardFileList");
        board.setId(loginUser.getId());
        try{
            int result = boardService.createBoard(board);
            int boardNo = boardService.findCurKey();
            if(boardFileList.get(0).getSize() != 0){
                String filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\static\\upload\\board\\";
                for(MultipartFile boardFile : boardFileList){
                    String fileName = fileService.uploadFile(boardFile,filePath);
                    BoardFile file = new BoardFile(0,fileName,boardNo);
                    boardFileService.createBoardFile(file);
                }
            }
            forwardPath = "redirect:/board/detail/"+boardNo;
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //4. 게시글 삭제하기
    @LoginCheck
    @GetMapping("/delete-action/{boardNo}")
    public String deleteBoardAction(@PathVariable int boardNo){
        String forwardPath ="";
        try{
            boardService.deleteBoard(boardNo);
            forwardPath = "redirect:/board/list/1";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //5. 게시글 수정하기
        //1) 수정폼
    @LoginCheck
    @GetMapping("/modify/{boardNo}")
    public String modifyBoard(@PathVariable int boardNo, Model model){
        String fowardPath = "";
        try{
            List<BoardFile> boardFileList = boardFileService.findByBoardNo(boardNo);
            Board board = boardService.findByBoardNo(boardNo);
            model.addAttribute("board",board);
            model.addAttribute("boardFileList",boardFileList);
            fowardPath="/board/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return fowardPath;
    }
        //2) 수정액션
    @LoginCheck
    @PostMapping("/modify-action/{boardNo}")
    public String modifyBoardAction(@PathVariable int boardNo,@ModelAttribute Board board, MultipartHttpServletRequest mf){
        String forwardPath = "";
        List<MultipartFile> boardFileList = mf.getFiles("boardFileList");
        try{
            int result = boardService.updateBoard(board);
            if(boardFileList.get(0).getSize() != 0){
                String filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\board\\";
                for(MultipartFile boardFile : boardFileList){
                    String fileName = fileService.uploadFile(boardFile,filePath);
                    BoardFile file = new BoardFile(0,fileName,boardNo);
                    boardFileService.createBoardFile(file);
                }
            }
            forwardPath = "redirect:/board/modify/"+boardNo;
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
}
