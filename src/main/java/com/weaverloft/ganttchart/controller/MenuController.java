package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import javax.xml.catalog.Catalog;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MenuController {
    private MenuService menuService;

    public MenuController(MenuService menuService) {
        this.menuService = menuService;
    }

    //1. 메뉴 만들기 페이지
    @GetMapping("menuWrite")
    public String menuCreate(){
        return "menuWrite";
    }
    //1-1. 메뉴(메뉴) 만들기 액션    //상위메뉴(parentId:0) 하위메뉴
    @PostMapping("menuWrite-action")
    public String menuCreateAction(@ModelAttribute Menu menu){
        String forwardPath="";
        try{
            int result = menuService.createMenu(menu);
            forwardPath = "redirect:menuList";
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


    //2-2. 메뉴 상세보기 페이지
    @GetMapping("menuDetail/{menuNo}")
    public String menuDetail(@PathVariable int menuNo,Model model){
        try{
            Menu menu = menuService.findMenuByNo(menuNo);
            model.addAttribute("menu",menu);
        } catch (Exception e){
            e.printStackTrace();
        }
        return "menuDetail";
    }

    //2-1. 메뉴 수정하기 액션
    @PostMapping("menuModify-action")
    public Map<String,Object> menuModifyAction(){
        Map<String,Object> resultMap = new HashMap<>();
        return resultMap;
    }


    //3. 메뉴 전체리스트 불러오기
    @GetMapping("menuList/{pageNo}")
    public String menuList(@PathVariable int pageNo, Model model){
        String forwardPath;
        try{
            PageMakerDto<Menu> menuListPage = menuService.findMenuList(pageNo);
            model.addAttribute("menuListPage",menuListPage);
        } catch (Exception e){
            e.printStackTrace();
        }
        return "menuList";
    }

    //4. 메뉴 삭제 액션
    @PostMapping("menuDelete-action")
    public String menuDeleteAction(int menuNo){
        try{
            int result = menuService.deleteMenu(menuNo);
        } catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:menuList";
    }
}
