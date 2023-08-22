package com.weaverloft.ganttchart.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;


@Controller
public class CryptoController {
    private  Logger logger = LoggerFactory.getLogger(CryptoController.class);

    //간단하게 메인페이지로 돌아오게 하기
    @GetMapping("/encode-password")
    public String byCrypt(Locale locale, Model model, HttpServletRequest request){
        logger.info("메인페이지, client의 locale : "+locale);
        WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
        PasswordEncoder passwordEncoder = context.getBean(PasswordEncoder.class);

        String password = request.getParameter("password");
        String encodePassword = passwordEncoder.encode(password);

        model.addAttribute("encodePassword", encodePassword);
        System.out.println("encodePassword = " + encodePassword);

        String forwardPath ="";
        forwardPath="/";

        return forwardPath;
    }
}
