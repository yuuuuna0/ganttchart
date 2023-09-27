package com.weaverloft.ganttchart.exception;

import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.dto.Menu;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {
    private MenuService menuService;

    public GlobalExceptionHandler(MenuService menuService) {
        this.menuService = menuService;
    }
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        System.out.println("menuList = " + menuList);
        return menuList;
    }

    @ExceptionHandler(Exception.class)
    protected String  ExceptionHandler(Model model){
        String forward ="";
        try{
            model.addAttribute("msg","관리자에게 문의하세요");
            forward = "redirect:/error";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forward;
    }
    @ExceptionHandler(SQLException.class)
    protected String  SQLExceptionHandler(Model model){
        String forward ="";
        try{
            model.addAttribute("msg","관리자에게 문의하세요");
            forward = "redirect:/error";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forward;
    }
    @ExceptionHandler(NoHandlerFoundException.class)
    protected String  NoHandlerFoundException(Model model){
        String forward ="";
        try{
            model.addAttribute("msg","잘못된 페이지 요청입니다.");
            forward = "redirect:/error";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forward;
    }
}
