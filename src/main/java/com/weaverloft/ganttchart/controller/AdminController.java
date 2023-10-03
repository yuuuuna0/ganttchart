package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.annotation.AdminCheck;
import com.weaverloft.ganttchart.controller.annotation.LoginCheck;
import com.weaverloft.ganttchart.dto.*;
import com.weaverloft.ganttchart.util.ExcelService;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
    private UsersService usersService;
    private MenuService menuService;
    private ExcelService excelService;
    private BoardService boardService;
    private GatheringService gatheringService;
    private CityService cityService;
    private GatheringTypeService gatheringTypeService;

    public AdminController(UsersService usersService,MenuService menuService,ExcelService excelService,BoardService boardService,GatheringService gatheringService,
                           CityService cityService,GatheringTypeService gatheringTypeService) {
        this.usersService = usersService;
        this.menuService = menuService;
        this.excelService = excelService;
        this.boardService = boardService;
        this.gatheringService = gatheringService;
        this.cityService = cityService;
        this.gatheringTypeService = gatheringTypeService;
    }

    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        return menuList;
    }

    //1. 회원리스트
//    @AdminCheck
    @LoginCheck
    @GetMapping(value = "/user/list")
    public String userListPage(Model model,
                           @RequestParam(required = false, defaultValue = "1") int pageNo,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String filterType,
                           @RequestParam(required = false) String ascDesc){
        String forwardPath = "";
        try{
            SearchDto<Users> searchUserList = usersService.findSearchedUserList(pageNo,keyword,filterType,ascDesc);
            model.addAttribute("searchUserList",searchUserList);
            //키워드, 정렬 넣어주기
            Map<String,Object> filterMap = new HashMap<>();
            filterMap.put("keyword",keyword);
            filterMap.put("filterType",filterType);
            filterMap.put("ascDesc",ascDesc);
            model.addAttribute("filterMap",filterMap);
            forwardPath = "/user/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1. 회원리스트 AJAX
//    @AdminCheck
    @LoginCheck
    @ResponseBody
    @PostMapping("/user/list.ajx")
    public Map<String,Object> listAjax(@RequestParam(required = false, defaultValue = "1") int pageNo,
                                       @RequestParam(required = false) String keyword,
                                       @RequestParam(required = false) String filterType,
                                       @RequestParam(required = false) String ascDesc){
        Map<String,Object> resultMap = new HashMap<>();
        try{
            resultMap.put("pageNo",pageNo);
            resultMap.put("keyword",keyword);
            resultMap.put("filterType",filterType);
            resultMap.put("ascDesc",ascDesc);
        } catch (Exception e){
            e.printStackTrace();
        }
        return resultMap;
    }

    //1-2. 엑셀 다운로드
    @AdminCheck
    @LoginCheck
    @RequestMapping("/user/list/download")
    public void excelDown(HttpServletRequest request, HttpServletResponse response) {
        try{
            excelService.excelDown(response,"회원리스트");
        } catch (Exception e){
            e.printStackTrace();
        }
    }


    //1. 메뉴등록페이지
    @LoginCheck
    @GetMapping("/menu/register")
    public String registerPage(Model model){
        String forwardPath ="";
        try{
            List<Menu> menuList = menuService.findMenuList();
            model.addAttribute("menuList",menuList);
            forwardPath = "/menu/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1. 메뉴 등록하기
    @LoginCheck
    @ResponseBody
    @PostMapping("/menu/register.ajx")
    public Map<String,Object> registerAjax(Menu menu){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            int result = 0;
            if(menu.getOrders() == 0){
                result = menuService.createMenu(menu);
            } else {
                int orders = menuService.countMenuByparentId(menu.getParentId());
                menu.setOrders(orders);
                result = menuService.createSubMenu(menu);
            }
            int menuNo = menuService.findCurNo();
            if(result == 1){
                code = 1;
                forwardPath = "/admin/menu/detail?menuNo="+menuNo;
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

    //2. 메뉴 상세보기
    @LoginCheck
    @GetMapping(value = "/menu/detail")
    public String detailPage(@RequestParam int menuNo,Model model){
        String forwardPath ="";
        try{
            Menu menu = menuService.findMenuByNo(menuNo);
            List<Menu> menuList = menuService.findMenuList();
            model.addAttribute("menu",menu);
            model.addAttribute("menuList",menuList);
            forwardPath = "/menu/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 메뉴 수정하기
    @LoginCheck
    @GetMapping(value = "/menu/modify")
    public String modifyPage(@RequestParam int menuNo,Model model){
        String forwardPath ="";
        try{
            Menu menu = menuService.findMenuByNo(menuNo);
            List<Menu> menuList = menuService.findMenuList();
            model.addAttribute("menu",menu);
            model.addAttribute("menuList",menuList);
            forwardPath = "/menu/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //3-1. 메뉴 수정하기 AJAX
    @LoginCheck
    @ResponseBody
    @PostMapping(value = "/menu/modify.ajx")
    public Map<String,Object> mofifyAjax(Menu menu){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath = "";
        try{
            int result = menuService.updateMenu(menu);
            if(result == 1){
                code = 1;
                forwardPath = "/menu/detail?menuNo="+menu.getMenuNo();
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

    //4. 전체메뉴 보기
    @LoginCheck
    @GetMapping(value = "/menu/list")
    public String listPage(Model model,
                           @RequestParam(required = false, defaultValue = "1") int pageNo,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String filterType,
                           @RequestParam(required = false) String ascDesc){
        String forwardPath ="";
        try{
            SearchDto<Menu> searchMenuList = menuService.findSearchedMenuList(pageNo,keyword,filterType,ascDesc);
            model.addAttribute("searchMenuList",searchMenuList);
            forwardPath="/menu/list";
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //4-1. 사용등급 변경 AJAX
    @LoginCheck
    @ResponseBody
    @PostMapping(value = "/menu/modifyAuth.ajx")
    public Map<String,Object> modifyAuth(@RequestParam int menuNo, String auth){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        try{
            int result = menuService.updateMenuAuth(menuNo,auth);
            if(result == 1){
                code =1;
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        return resultMap;
    }
    //5. 메뉴 삭제
    @LoginCheck
    @GetMapping(value = "/menu/delete.aciton")
    public String deleteMenu(@RequestParam int menuNo){
        String forwardPath ="";
        try{
            int result = menuService.deleteMenu(menuNo);
            forwardPath="redirect:/admin/menu/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //6. 관리자 게시글리스트
    @LoginCheck
    @GetMapping("/board/list")
    public String boardListPage(Model model,
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
    //관리자 모임리스트
    @LoginCheck
    @GetMapping("/gathering/list")
    public String gatheringListPage(Model model,
                                    @RequestParam(required = false, defaultValue = "1") int pageNo,
                                    @RequestParam(required = false) String keyword,
                                    @RequestParam(required = false) String filterType,
                                    @RequestParam(required = false) String ascDesc,
                                    @RequestParam(required = false, defaultValue = "0") int cityNo,
                                    @RequestParam(required = false, defaultValue = "0") int gathTypeNo,
                                    @RequestParam(required = false, defaultValue = "0") int gathStatusNo){
        String forwardPath = "";
        try{
            SearchDto<Gathering> searchGathList = gatheringService.findSearchedGathList(pageNo,keyword,filterType,ascDesc,cityNo,gathTypeNo,gathStatusNo);
            model.addAttribute("searchGathList",searchGathList);
            System.out.println("searchGathList = " + searchGathList);
            model.addAttribute("keyword",keyword);
            forwardPath = "/gathering/list_admin";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


}
