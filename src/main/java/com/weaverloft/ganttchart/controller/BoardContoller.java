package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.annotation.LoginCheck;
import com.weaverloft.ganttchart.dto.*;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
public class BoardContoller {
    private BoardService boardService;
    private FilesService filesService;
    private UsersService usersService;
    private CommentsService commentsService;
    private MenuService menuService;

    public BoardContoller(BoardService boardService, FilesService filesService, UsersService usersService,CommentsService commentsService,MenuService menuService) {
        this.boardService = boardService;
        this.filesService = filesService;
        this.usersService = usersService;
        this.commentsService = commentsService;
        this.menuService = menuService;
    }

    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        return menuList;
    }

    //1. 게시글리스트페이지
    @GetMapping(value = "/list")
    public String listPage(Model model,
                           @RequestParam(required = false, defaultValue = "1") int pageNo,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String filterType,
                           @RequestParam(required = false) String ascDesc){
        String forwardPath = "";
        try{
            SearchDto<Board> searchBoardList = boardService.findSearchedUserList(pageNo,keyword,filterType,ascDesc);
            List<Users> userList = usersService.findUserList();
            model.addAttribute("searchBoardList",searchBoardList);
            model.addAttribute("userList",userList);
            model.addAttribute("keyword",keyword);
            forwardPath="/board/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //2. 게시글 상세보기 페이지
    @GetMapping(value = "/detail")
    public String detailPage(@RequestParam int boardNo, Model model){
        String forwardPath = "";
        try{
            int result = boardService.increaseReadCount(boardNo);
            Board board = boardService.findBoardByNo(boardNo);
            List<Files> fileList = filesService.findFileByBoardNo(boardNo);
            List<Comments> commentList = commentsService.findCommentByBoardNo(boardNo);
            List<Comments> preCommentList = commentsService.findPreCommentByBoardNo(boardNo);
            Users user = usersService.findUserById(board.getUId());
            model.addAttribute("board",board);
            model.addAttribute("fileList",fileList);
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
    @LoginCheck
    @GetMapping("/register")
    public String registerPage(Model model){
        String forwardPath = "";
        try{
            forwardPath="/board/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //3-1. 게시글 작성하기 AJAX
    @LoginCheck
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
    @LoginCheck
    @GetMapping(value = "/modify")
    public String modifyPage(@RequestParam int boardNo,Model model){
        String forwardPath = "";
        try{
            Board board = boardService.findBoardByNo(boardNo);
            List<Files> fileList = filesService.findFileByBoardNo(boardNo);
            Users user = usersService.findUserById(board.getUId());
            model.addAttribute("board",board);
            model.addAttribute("fileList",fileList);
            model.addAttribute("user",user);
            forwardPath="/board/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //4-1. 게시글 수정하기 AJAX
    @LoginCheck
    @ResponseBody
    @PostMapping(value = "/modify.ajx")
    public Map<String,Object> modifyAjax(@RequestParam int boardNo, Board board, @RequestPart(required = false) List<MultipartFile> fileList
                                           ,@RequestParam(required = false) List<String> nameList){
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

    //5. 게시글 삭제하기
    @LoginCheck
    @GetMapping("/delete.action")
    public String deleteBoard(@RequestParam int boardNo){
        String forwardPath="";
        try{
            int result = boardService.deleteBoard(boardNo);
        } catch (Exception e){
            e.printStackTrace();
        }
        return  forwardPath;
    }

    @GetMapping("/download")
    public void downloadFile(@RequestParam int fileNo, HttpServletRequest request, HttpServletResponse response) {
        try {
            Files file = filesService.findFileByNo(fileNo);
            String saveFileName = file.getSaveName();
            String originalFileName = file.getOriginalName();
            String filePath = file.getFilePath();

            // globals.properties
            File downloadFile = new File(filePath + saveFileName);
            BufferedInputStream in = new BufferedInputStream(new FileInputStream(downloadFile));
            //byte fileByte[] = FileUtils.readFileToByteArray(downloadFile);

            //User-Agent : 어떤 운영체제로  어떤 브라우저를 서버( 홈페이지 )에 접근하는지 확인함
            String header = request.getHeader("User-Agent");
            String fileName;

            if ((header.contains("MSIE")) || (header.contains("Trident")) || (header.contains("Edge"))) {
                //인터넷 익스플로러 10이하 버전, 11버전, 엣지에서 인코딩
                fileName = URLEncoder.encode(originalFileName, "UTF-8");
            } else {
                //나머지 브라우저에서 인코딩
                fileName = new String(originalFileName.getBytes("UTF-8"), "iso-8859-1");
            }
            //형식을 모르는 파일첨부용 contentType
            response.setContentType("application/octet-stream");
            //다운로드와 다운로드될 파일이름
            response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFileName + "\"");
            //파일복사
            FileCopyUtils.copy(in, response.getOutputStream());
            in.close();
            response.getOutputStream().flush();
            response.getOutputStream().close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
