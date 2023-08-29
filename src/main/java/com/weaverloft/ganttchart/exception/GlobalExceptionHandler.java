package com.weaverloft.ganttchart.exception;

import com.weaverloft.ganttchart.Service.MenuService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {
    private MenuService menuService;

    public GlobalExceptionHandler(MenuService menuService) {
        this.menuService = menuService;
    }

    @ExceptionHandler(Exception.class)
    protected String  ExceptionHandler(Model model){
        String forward ="";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList",map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));
        } catch (Exception e){
            e.printStackTrace();
        }
        model.addAttribute("msg","관리자에게 문의하세요");
        forward = "redirect:/error";
        return forward;
    }
}
