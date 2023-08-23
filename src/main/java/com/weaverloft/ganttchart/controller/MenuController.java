package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.controller.Interceptor.AdminCheck;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.xml.catalog.Catalog;
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

    //1. 메뉴 만들기 페이지
    @AdminCheck
    @GetMapping("/register")
    public String menuCreate(){
        return "/menu/register";
    }
    //1-1. 메뉴(메뉴) 만들기 액션    //상위메뉴(parentId:0) 하위메뉴
    @AdminCheck
    @PostMapping("/register-action")
    public String menuCreateAction(@ModelAttribute Menu menu){
        String forwardPath="";
        try{
            int result = menuService.createMenu(menu);
            forwardPath = "redirect:/menu/list/1";
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


    //2-2. 메뉴 상세보기 페이지
    @AdminCheck
    @GetMapping("/detail/{menuNo}")
    public String menuDetail(@PathVariable int menuNo,Model model){
        String forwardPath = "";
        try{
            Menu menu = menuService.findMenuByNo(menuNo);
            model.addAttribute("menu",menu);
            forwardPath = "/menu/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //2-1. 메뉴 수정하기 액션
    @AdminCheck
    @PostMapping("/modify-action/{menuNo}")
    public String menuModifyAction(@PathVariable int menuNo, @ModelAttribute Menu menu) {
        String forwardPath = "";
        try{
            int result = menuService.updateMenu(menu);
            forwardPath = "redirect:/menu/detail/"+menu.getMenuNo();
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 메뉴 전체리스트 불러오기
    @AdminCheck
    @GetMapping("/list/{pageNo}")
    public String menuList(@PathVariable int pageNo, Model model){
        String forwardPath = "";
        try{
            PageMakerDto<Menu> menuListPage = menuService.findMenuList(pageNo);
            model.addAttribute("menuListPage",menuListPage);
            forwardPath = "/menu/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //4. 메뉴 삭제 액션
    @AdminCheck
    @PostMapping("delete-action/{menuNo}")
    public String menuDeleteAction(@PathVariable int menuNo){
        String forwardPath = "";
        try{
            int result = menuService.deleteMenu(menuNo);
            forwardPath = "redirect:/menu/list/1";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
}
