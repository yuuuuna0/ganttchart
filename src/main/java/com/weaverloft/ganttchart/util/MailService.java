package com.weaverloft.ganttchart.util;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import java.util.Random;

@Service
public class MailService {
    private JavaMailSender mailSender;
    private String senderEmail = "owing0624@gmail.com";
    private int authCode;
    private String tempPassword;

    //숫자 6자리 이메일 인증코드
    public void createAuthCode(){
        authCode = 0;
        Random random = new Random();
        for(int i=0; i<6; i++){
            authCode = authCode * 10 + random.nextInt(10);  //0~9
        }
    }
    //10자리 임시 비밀번호 생성
    public void createTempPassword(){
        StringBuffer key = new StringBuffer();
        Random random = new Random();
        tempPassword = "";
        for(int i=0;i<10;i++){
            int index = random.nextInt(3);
            switch (index){
                case 0:
                    key.append((char)((int)(random.nextInt(26))+97)); //a~z (ex.1+97=98 =>(char)98 ='b')
                    break;
                case 1:
                    key.append((char)((int)random.nextInt(26))+65); //A~Z (ex.1+65=66 =>(char)66 ='B')
                    break;
                case 2:
                    key.append(random.nextInt(10));
                    break;
            }
        }
        tempPassword = key.toString();
    }

    //메일 발송
    public String sendMail(String email, int typeNo) throws MessagingException {
        //typeNo --> 1:인증메일 2:임시비번
        String body ="";
        String result ="";
        String subject = "";
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        switch (typeNo) {
            case 1:
                createAuthCode();
                body += "<h3>" + "요청하신 인증 번호입니다." + "</h3>\n" +
                        "<h1>" + authCode + "</h1>\n" +
                        "<h3>" + "감사합니다." + "</h3>";
                subject = "[WEAVER]이메일 인증메일입니다.";
                result = Integer.toString(authCode);
                break;
            case 2:
                createTempPassword();
                body += "<h3>" + "임시비밀번호 입니다." + "</h3>\n" +
                        "<h1>" + tempPassword + "</h1>\n" +
                        "<h3>" + "로그인 후 비밀번호를 변경 해 주세요" + "</h3>";
                subject = "[WEAVER]임시 비밀번호입니다.";
                result = tempPassword;
                break;
        }
        mailMessage.setFrom(senderEmail);
        mailMessage.setTo(email);
        mailMessage.setSubject(subject);
        mailMessage.setText(body);
        return result;
    }

}
