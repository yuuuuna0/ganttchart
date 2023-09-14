package com.weaverloft.ganttchart.util;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    private String senderEmail = "owing0624@gmail.com";

    //6자리 인증코드
    private String createNumCode(){
        int numCode = 0;
        Random random = new Random();
        for(int i=0;i<6;i++){
            numCode = numCode * 10 + random.nextInt(10);
        }
        return Integer.toString(numCode);
    }
    private String createMixCode(){
        StringBuffer key = new StringBuffer();
        Random random = new Random();
        for(int i=0;i<10;i++){
            int index = random.nextInt(3);
            switch(index){
                case 0: //a~z (ex.1+97=98 =>(char)98 ='b')
                    key.append((char)((int)(random.nextInt(26))+97));
                    break;
                case 1: //A~Z (ex.1+65=66 =>(char)66 ='B')
                    key.append((char)((int)(random.nextInt(26))+97));
                    break;
                case 2:
                    key.append(random.nextInt(10));
                    break;
            }
        }
        return key.toString();
    }

    public String sendMail(String email,int uStatusNo){
        String code ="";
        String subject ="";
        String body ="";
        switch (uStatusNo){
            case 1: //인증메일
                code = createNumCode();
                body += "<h3>" + "요청하신 인증 번호입니다." + "</h3>\n" +
                        "<h1>" + code + "</h1>\n" +
                        "<h3>" + "감사합니다." + "</h3>";
                subject = "[WEAVER]이메일 인증메일입니다.";
                break;
            case 2: //임시비번
                code = createMixCode();
                body += "<h3>" + "임시비밀번호 입니다." + "</h3>\n" +
                        "<h1>" + code + "</h1>\n" +
                        "<h3>" + "로그인 후 비밀번호를 변경 해 주세요" + "</h3>";
                subject = "[WEAVER]임시 비밀번호입니다.";
                break;
        }
        MimeMessage mail = mailSender.createMimeMessage();
        try{
            mail.setFrom(senderEmail);
            mail.setSubject(subject);
            mail.setText(body,"UTF-8", "html");
            mail.setRecipient(Message.RecipientType.TO,new InternetAddress(email));
            mailSender.send(mail);
        } catch (MessagingException e){
            e.printStackTrace();
        }
        return code;
    }



}
