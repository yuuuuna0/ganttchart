package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.Interceptor.LoginCheck;
import com.weaverloft.ganttchart.dto.Board;
import com.weaverloft.ganttchart.dto.BoardFile;
import com.weaverloft.ganttchart.dto.Comments;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;
import oracle.jdbc.proxy.annotation.Pre;
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
import java.util.*;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/board/*")
public class BoardController {
    private BoardService boardService;
    private BoardFileService boardFileService;
    private FileService fileService;
    private CommentsService commentsService;
    private MenuService menuService;
    private UsersService usersService;

    public BoardController(BoardService boardService, BoardFileService boardFileService,
                           FileService fileService, CommentsService commentsService,
                           MenuService menuService, UsersService usersService) {
        this.boardService = boardService;
        this.boardFileService = boardFileService;
        this.fileService = fileService;
        this.commentsService = commentsService;
        this.menuService = menuService;
        this.usersService = usersService;
    }

    //1. 게시글 전체보기 페이지
    @LoginCheck
    @GetMapping("/list")
    public String boardList(@RequestParam(required = false, defaultValue = "1") int pageNo,
                            @RequestParam(required = false, defaultValue = "") String keyword,
                            Model model,HttpSession session) {
        String forwardPath="";
        try{
//            //cm_left data
//            Map<String, Object> map = menuService.cmLeftMenuList();
//            model.addAttribute("menuList", map.get("menuList"));
//            model.addAttribute("preMenuList",map.get("preMenuList"));

            if(keyword.equals("")) keyword=null;
            List<Users> userList = usersService.findAllUsers();
            PageMakerDto<Board> boardListPage = boardService.findBoardList(pageNo,keyword);
            model.addAttribute("boardListPage",boardListPage);
            model.addAttribute("userList",userList);
            model.addAttribute("keyword",keyword);
            forwardPath="/board/list";
        } catch (Exception e){
            e.printStackTrace();
            forwardPath="/error";
        }
        return forwardPath;
    }

    //2. 게시글 상세보기 페이지
    @LoginCheck
    @GetMapping("/detail/{boardNo}")
    public String boardDetail(@PathVariable int boardNo,Model model,HttpSession session) {
        String forwardPath = "";
        try {
//            //cm_left data
//            Map<String, Object> map = menuService.cmLeftMenuList();
//            model.addAttribute("menuList", map.get("menuList"));
//            model.addAttribute("preMenuList",map.get("preMenuList"));

            Users loginUsers =(Users)session.getAttribute("loginUser");
            int result = boardService.updateBoardReadcount(boardNo);
            Board board = boardService.findByBoardNo(boardNo);
            Users boardWriter = usersService.findUsersById(board.getId());
            List<BoardFile> boardFileList = boardFileService.findByBoardNo(boardNo);
            List<Comments> commentsList = commentsService.findCommentsByBoardNo(boardNo);
            if(board!=null){
                model.addAttribute("board", board);
                model.addAttribute("boardFileList",boardFileList);
                model.addAttribute("commentsList", commentsList);
                model.addAttribute("boardWriter",boardWriter);
                forwardPath ="/board/detail";
            }
            //수정 삭제 권한 붙이기
            boolean privilege;
            if(board.getId().equals(loginUsers.getId()) || loginUsers.getGrade()==0){
                privilege = true;
                model.addAttribute("privilegeB", privilege);
            } else if(loginUsers.getGrade()==0){
                // 코멘트 권한 붙이는 방법?
                privilege = true;

            }
            else {
                privilege = false;
                model.addAttribute("privilege", privilege);
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
//            //cm_left data
//            Map<String, Object> map = menuService.cmLeftMenuList();
//            model.addAttribute("menuList", map.get("menuList"));
//            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }
        return "board/register";
    }
    //3-1 게시글 작성하기 액션
    @LoginCheck
    @ResponseBody
    @PostMapping("/register-ajax")
    public Map<String,Object> boardCreateAjax(@RequestParam Map<String ,Object> map, @RequestParam(value = "fileArray",required = false) List<MultipartFile> boardFileList, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        Users loginUser=(Users)session.getAttribute("loginUser");
        Board board = new Board(0,(String)map.get("boardTitle"),(String)map.get("boardContent"),new Date(),loginUser.getId(),0);
        try{
            int result = boardService.createBoard(board);
            int boardNo = boardService.findCurKey();
            if(boardFileList != null){
                String filePath = "C:\\gantt\\upload\\board\\"; //하드코딩 안하면 어디에
                for(MultipartFile boardFile : boardFileList){
                    String originalFileName = boardFile.getOriginalFilename();
                    String saveFileName = fileService.uploadFile(boardFile,filePath);
                    long fileSize = boardFile.getSize();
                    BoardFile file = new BoardFile(0,saveFileName,originalFileName,filePath,fileSize,boardNo);
                    boardFileService.createBoardFile(file);
                }
            }
            code = 1;
            forwardPath = "/board/detail/"+boardNo;
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "알 수 없는 에러가 발생하였습니다. 관리자에게 문의하세요";
            forwardPath="/board/register";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //4. 게시글 삭제하기
    @LoginCheck
    @GetMapping("/delete-action/{boardNo}")
    public String deleteBoardAction(@PathVariable int boardNo){
        String forwardPath ="";
        try{
            boardService.deleteBoard(boardNo);
            forwardPath = "redirect:/board/list?pageNo=1&keyword=";
        } catch (Exception e){
            e.printStackTrace();
            forwardPath="/error";
        }
        return forwardPath;
    }

    //5. 게시글 수정하기 페이지
    @LoginCheck
    @GetMapping("/modify/{boardNo}")
    public String modifyBoard(@PathVariable int boardNo, Model model){
        String fowardPath = "";
        try{
//            //cm_left data
//            Map<String, Object> map = menuService.cmLeftMenuList();
//            model.addAttribute("menuList", map.get("menuList"));
//            model.addAttribute("preMenuList",map.get("preMenuList"));

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
    @ResponseBody
    @PostMapping("/modify-ajax")
    public Map<String,Object> modifyBoardAjax(@RequestParam Map<String ,Object> map, @RequestParam(value="fileArray",required = false) List<MultipartFile> boardFileList){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        int boardNo = Integer.parseInt(map.get("boardNo").toString());
        Board board = new Board(boardNo,(String)map.get("boardTitle"),(String)map.get("boardContent"),new Date(),"",0);
        try{
            int result = boardService.updateBoard(board);
            //기존 파일번호리스트 불러와서 대조하여 삭제
            List<BoardFile> fileList = boardFileService.findByBoardNo(boardNo);
            System.out.println("fileList = " + fileList);
            String fileNoArrStr = (String)map.get("fileNoList");
            String[] fileNoStrArr = fileNoArrStr.split(",");
            int[] fileNoArr = Arrays.stream(fileNoStrArr).mapToInt(Integer::parseInt).toArray();
            for(int i =0 ; i<fileList.size();i++){
                int no = fileList.get(i).getFileNo();
                if(!IntStream.of(fileNoArr).anyMatch(x -> x == no)){ //fileList에 들은 fileNo가 array에 없으면 삭제
                    boardFileService.deleteFile(no);
                }
            }
            if(boardFileList != null){
                String filePath = "C:\\gantt\\upload\\board\\";
                for(MultipartFile boardFile : boardFileList){
                    String originalFileName = boardFile.getOriginalFilename();
                    String saveFileName = fileService.uploadFile(boardFile,filePath);
                    long fileSize = boardFile.getSize();
                    BoardFile file = new BoardFile(0,saveFileName,originalFileName,filePath,fileSize,boardNo);
                    boardFileService.createBoardFile(file);
                }
            }
            code = 1;
            forwardPath = "/board/detail/"+boardNo;
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "알 수 없는 에러가 발생하였습니다. 관리자에게 문의하세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }

    //6. 파일 다운로드
    @LoginCheck
    @GetMapping("/downloadFile")
    public void downloadFile(@RequestParam int fileNo, HttpServletRequest request, HttpServletResponse response){
        try{
            BoardFile file = boardFileService.findFileByNo(fileNo);
            String saveFileName = file.getSaveFileName();
            String originalFileName = file.getOriginalFileName();
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
            response.setHeader("Content-Disposition", "attachment; filename=\""+ originalFileName + "\"");
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
