package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.dto.Users;
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

    public AdminController(UsersService usersService,MenuService menuService,ExcelService excelService) {
        this.usersService = usersService;
        this.menuService = menuService;
        this.excelService = excelService;
    }

    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        System.out.println("menuList = " + menuList);
        return menuList;
    }

    //1. 회원리스트
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
            forwardPath = "/user/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1. 회원리스트 AJAX
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
    @RequestMapping("/user/list/download")
    public void excelDown(HttpServletRequest request, HttpServletResponse response) {
        try{
            excelService.excelDown(response,"회원리스트");
        } catch (Exception e){
            e.printStackTrace();
        }
    }


    //1. 메뉴등록페이지
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
                forwardPath = "/menu/detail?menuNo="+menuNo;
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
    @ResponseBody
    @PostMapping(value = "/menu/modifyAuth.ajx")
    public Map<String,Object> modifyUTypeNo(@RequestParam int menuNo, String auth){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        try{
            int result = menuService.updateMenuUType(menuNo,auth);
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
    @GetMapping(value = "/menu/delete.aciton")
    public String deleteMenu(@RequestParam int menuNo){
        String forwardPath ="";
        try{
            int result = menuService.deleteMenu(menuNo);
            forwardPath="redirect:/menu/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


}
