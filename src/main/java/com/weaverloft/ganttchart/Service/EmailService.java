package com.weaverloft.ganttchart.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;
    private String senderEmail = "owing0624@gmail.com";
    private int authCode; //인증코드

    public void createAuthCode(){
        //6자리 이메일 인증코드  생성
        authCode=0;
        Random random=new Random();
        for(int i=0; i<6;i++){
            authCode = authCode * 10 +random.nextInt(10);
        }
    }

    public MimeMessage CreateEMail(String email){
        createAuthCode();   //인증코드 생성
        MimeMessage message= emailSender.createMimeMessage();
        try{
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO,email);
            message.setSubject("이메일 인증");
            String body="";
            body += "<h3>" + "요청하신 인증 번호입니다." + "</h3>";
            body += "<h1>" + authCode + "</h1>";
            body += "<h3>" + "감사합니다." + "</h3>";
            message.setText(body,"UTF-8", "html");
        } catch (MessagingException e){
            e.printStackTrace();
        }
        return message;
    }

    public int sendMail(String email){
        MimeMessage message = CreateEMail(email);
        emailSender.send(message);
        return authCode;
    }
}

