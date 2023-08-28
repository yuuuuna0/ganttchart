package com.weaverloft.ganttchart.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    protected String  ExceptionHandler(Model model){
        String forward ="";
        model.addAttribute("msg","관리자에게 문의하세요");
        forward = "/error";
        return forward;
    }
}
