package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.BoardFile;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board/*")
public class BoardController {
    private BoardService boardService;
    private BoardFileService boardFileService;
    private FileService fileService;
    private CommentsService commentsService;
    private MenuService menuService;

    public BoardController(BoardService boardService, BoardFileService boardFileService,
                           FileService fileService, CommentsService commentsService,
                           MenuService menuService) {
        this.boardService = boardService;
        this.boardFileService = boardFileService;
        this.fileService = fileService;
        this.commentsService = commentsService;
        this.menuService = menuService;
    }

    //1. 게시글 전체보기 페이지
    @GetMapping("/list")
    public String boardList(@RequestParam(required = false, defaultValue = "1") int pageNo,
                            @RequestParam(required = false, defaultValue = "") String keyword,
                            Model model,HttpSession session) {
        String forwardPath="";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            if(keyword.equals("")) keyword=null;

            Users loginUser = (Users)session.getAttribute("loginUser");
            PageMakerDto<Board> boardListPage = boardService.findBoardList(pageNo,keyword);
            model.addAttribute("boardListPage",boardListPage);
            model.addAttribute("keyword",keyword);
            forwardPath="/board/list";
        } catch (Exception e){
            e.printStackTrace();
            forwardPath="/error";
        }
        return forwardPath;
    }

    //2. 게시글 상세보기 페이지
    @GetMapping("/detail/{boardNo}")
    public String boardDetail(@PathVariable int boardNo,Model model) {
        String forwardPath = "";
        try {
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

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
    public String boardCreate(Model model){
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }
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
                    long fileSize = (boardFile.getSize())/1000;
                    System.out.println("fileSize = " + fileSize);
                    String fileSizeStr = fileSize+"kb";
                    BoardFile file = new BoardFile(0,fileName,fileSizeStr,boardNo);
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

    //5. 게시글 수정하기 페이지
    @LoginCheck
    @GetMapping("/modify/{boardNo}")
    public String modifyBoard(@PathVariable int boardNo, Model model){
        String fowardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

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
        //5-2. 게시글 수정하기 액션
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
                    long fileSize = boardFile.getSize();
                    System.out.println("fileSize = " + fileSize);
                    String fileSizeStr = fileSize+"kb";
                    BoardFile file = new BoardFile(0,fileName,fileSizeStr,boardNo);
                    boardFileService.createBoardFile(file);
                }
            }
            forwardPath = "redirect:/board/modify/"+boardNo;
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //6. 파일 다운로드
    @GetMapping("/downloadFile")
    public void downloadFile(@RequestParam int fileNo, HttpServletRequest request, HttpServletResponse response){
        try{
            BoardFile file = boardFileService.findFileByNo(fileNo);
            String saveFileName = (String)file.getFileName();
            String filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\board\\";

            // globals.properties
            File downloadFile = new File(filePath + saveFileName);
            BufferedInputStream in = new BufferedInputStream(new FileInputStream(downloadFile));
            //byte fileByte[] = FileUtils.readFileToByteArray(downloadFile);

            //User-Agent : 어떤 운영체제로  어떤 브라우저를 서버( 홈페이지 )에 접근하는지 확인함
            String header = request.getHeader("User-Agent");
            String fileName;

            if ((header.contains("MSIE")) || (header.contains("Trident")) || (header.contains("Edge"))) {
                //인터넷 익스플로러 10이하 버전, 11버전, 엣지에서 인코딩
                fileName = URLEncoder.encode(saveFileName, "UTF-8");
            } else {
                //나머지 브라우저에서 인코딩
                fileName = new String(saveFileName.getBytes("UTF-8"), "iso-8859-1");
            }
            //형식을 모르는 파일첨부용 contentType
            response.setContentType("application/octet-stream");
            //다운로드와 다운로드될 파일이름
            response.setHeader("Content-Disposition", "attachment; filename=\""+ fileName + "\"");
            //파일복사
            FileCopyUtils.copy(in, response.getOutputStream());
            in.close();
            response.getOutputStream().flush();
            response.getOutputStream().close();

        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
