package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/menu/*")
public class MenuController {
    private MenuService menuService;

    public MenuController(MenuService menuService) {
        this.menuService = menuService;
    }

    //1. 메뉴등록페이지
    @GetMapping("/register")
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
    @PostMapping("/register.ajx")
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
    @GetMapping(value = "/detail")
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
    @GetMapping(value = "/modify")
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
    @PostMapping(value = "/modify.ajx")
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
    @GetMapping(value = "/list")
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
    @PostMapping(value = "/modifyUType.ajx")
    public Map<String,Object> modifyUTypeNo(@RequestParam int menuNo, int uTypeNo){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        try{
            int result = menuService.updateMenuUType(menuNo,uTypeNo);


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
    @GetMapping(value = "/delete.aciton")
    public String deleteMenu(@RequestParam int menuNo){
        String forwardPath ="";
        try{
            int result = menuService.deleteMenu(menuNo);
            forwardPath="redirect:/menu/list?pageNo=1&keyword=";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

}
