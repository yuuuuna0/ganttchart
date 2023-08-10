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
    private String tempPassword;    //임시비밀번호

    ////6자리 이메일 인증코드 생성
    public void createAuthCode(){
        authCode=0;
        Random random=new Random();
        for(int i=0; i<6;i++){
            authCode = authCode * 10 +random.nextInt(10);
        }
    }

    //10자리 임시 비밀번호 생성
    public void createTempPassword(){
        StringBuffer key=new StringBuffer();
        Random random=new Random();
        tempPassword="";
        for(int i=0;i<10;i++){  //10자리 임시 비밀번호
            int index=random.nextInt(3); //case 0~2까지 랜덤
            switch(index){
                case 0:
                    key.append((char)((int)(random.nextInt(26))+97));   //a~z (ex.1+97=98 =>(char)98 ='b')
                    break;
                case 2:
                    key.append((char)((int)(random.nextInt(26))+65)); //A~Z (ex.1+65=66 =>(char)66 ='B')
                    break;
                case 3:
                    key.append(random.nextInt(10)); //0~9
                    break;
            }
        }
        tempPassword=key.toString();
    }

    /***************************인증메일 발송******************************/
    public int sendAuthEmail(String email){
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
        emailSender.send(message);
        return authCode;
    }
    /***************************임시비번메일 발송******************************/
    public String sendTempPasswordEmail(String email){
        createTempPassword();   //임시비번 생성
        MimeMessage message= emailSender.createMimeMessage();
        try{
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO,email);
            message.setSubject("임시비밀번호");
            String body="";
            body += "<h3>" + "임시비밀번호 입니다." + "</h3>";
            body += "<h1>" + tempPassword + "</h1>";
            body += "<h3>" + "로그인 후 비밀번호를 변경 해 주세요" + "</h3>";
            message.setText(body,"UTF-8", "html");
        } catch (MessagingException e){
            e.printStackTrace();
        }
        emailSender.send(message);
        return tempPassword;
    }






}

