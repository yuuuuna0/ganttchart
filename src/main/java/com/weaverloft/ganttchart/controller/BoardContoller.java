package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.BoardService;
import com.weaverloft.ganttchart.Service.CommentsService;
import com.weaverloft.ganttchart.Service.FilesService;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Files;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board/*")
public class BoardContoller {
    private BoardService boardService;
    private FilesService filesService;
    private UsersService usersService;
    private CommentsService commentsService;

    public BoardContoller(BoardService boardService, FilesService filesService, UsersService usersService,CommentsService commentsService) {
        this.boardService = boardService;
        this.filesService = filesService;
        this.usersService = usersService;
        this.commentsService = commentsService;
    }

    //1. 게시글리스트페이지
    @GetMapping(value = "/list", params = {"pageNo","keyword"})
    public String listPage(Model model,@RequestParam(required = false, defaultValue = "1")int pageNo, @RequestParam(required = false, defaultValue = "")String keyword){
        String forwardPath = "";
        try{
            List<Board> boardList = boardService.findBoardList();
            List<Users> userList = usersService.findUserList();
            model.addAttribute("boardList",boardList);
            model.addAttribute("userList",userList);
            forwardPath="/board/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //2. 게시글 상세보기 페이지
    @GetMapping(value = "/detail", params = "boardNo")
    public String detailPage(@RequestParam int boardNo, Model model){
        String forwardPath = "";
        try{
            int result = boardService.increaseReadCount(boardNo);
            Board board = boardService.findBoardByNo(boardNo);
            List<Files> filesList = filesService.findFileByBoardNo(boardNo);
            List<Comments> commentList = commentsService.findCommentByBoardNo(boardNo);
            List<Comments> preCommentList = commentsService.findPreCommentByBoardNo(boardNo);
            Users user = usersService.findUserById(board.getUId());
            model.addAttribute("board",board);
            model.addAttribute("fileList",filesList);
            model.addAttribute("commentList",commentList);
            model.addAttribute("preCommentList",preCommentList);
            model.addAttribute("user",user);
            forwardPath="/board/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //3. 게시글 작성하기 페이지
    @GetMapping("/register")
    public String registerPage(){
        String forwardPath = "";
        try{
            forwardPath="/board/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //3-1. 게시글 작성하기 AJAX
    @ResponseBody
    @PostMapping("/register.ajx")
    public Map<String,Object> registerAjax(Board board, @RequestPart(required = false) List<MultipartFile> fileList, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        try{
            Users user = (Users) session.getAttribute("loginUser");
            board.setUId(user.getUId());
            int result = boardService.createBoard(board);
            int boardNo = boardService.findCurNo();
            if(fileList != null){
                for(int i=0;i<fileList.size();i++){
                    MultipartFile mf = fileList.get(i);
                    Map<String,Object> map= filesService.uploadFile(mf,4);
                    Files file = new Files(0,
                            (String)map.get("saveName"),
                            (String)map.get("originalName"),
                            (String)map.get("filePath"),
                            (String)map.get("fileExt"),
                            "Y",
                            null,
                            0,0,boardNo,
                            (Long)map.get("fileSize"));
                    filesService.createFile(file,4);
                }
            }
            if(result ==1){
                code = 1;
                forwardPath = "/board/detail?boardNo="+boardNo;
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //4. 게시글 수정하기 페이지
    @GetMapping(value = "/modify", params = "boardNo")
    public String modifyPage(@RequestParam int boardNo,Model model){
        String forwardPath = "";
        try{
            Board board = boardService.findBoardByNo(boardNo);
            List<Files> filesList = filesService.findFileByBoardNo(boardNo);
            Users user = usersService.findUserById(board.getUId());
            model.addAttribute("board",board);
            model.addAttribute("fileList",filesList);
            model.addAttribute("user",user);
            forwardPath="/board/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //4-1. 게시글 수정하기 AJAX
    @ResponseBody
    @PostMapping(value = "/modify.ajx", params = "boardNo")
    public Map<String,Object> modifyAjax(@RequestParam int boardNo, Board board, @RequestPart(required = false) List<MultipartFile> fileList
                                            /*,들어오는파일리스트이름?? list? map?*/, List<String> nameList){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        try{
            //1)기존파일(String으로 들어오는 파일) 현재 파일과 비교해서 없는건 isUse N으로 변경해야한다. --> 너무 복잡?
            List<Files> extFileList = filesService.findFileByBoardNo(boardNo);
            for(int i=0;i<extFileList.size();i++){
                Files file = extFileList.get(i);
                for(int j=0;j<nameList.size();j++){
                    if(!file.getOriginalName().equals(nameList.get(j))){
                        file.setIsUse("N");
                    }
                }
            }
            //2) 파일 업로드
            if(fileList != null){
                for(int i=0;i<fileList.size();i++){
                    MultipartFile mf = fileList.get(i);
                    Map<String,Object> map= filesService.uploadFile(mf,4);
                    Files file = new Files(0,
                            (String)map.get("saveName"),
                            (String)map.get("originalName"),
                            (String)map.get("filePath"),
                            (String)map.get("fileExt"),
                            "Y",
                            null,
                            0,0,boardNo,
                            (Long)map.get("fileSize"));
                    filesService.createFile(file,4);
                }
            }
            //3) 게시글 업데이트
            int result = boardService.updateBoard(board);
            if(result == 1){
                code = 1;
                forwardPath = "/board/detail?boardNo="+boardNo;
            }

        }catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

}
