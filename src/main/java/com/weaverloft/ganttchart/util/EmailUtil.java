package com.weaverloft.ganttchart.util;

import jakarta.activation.DataSource;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;

@Repository
public class EmailUtil {
    private JavaMailSender mailSender;
    private MimeMessage message;
    private MimeMessageHelper messageHelper;

    public EmailUtil(JavaMailSender mailSender) throws Exception{
        this.mailSender = mailSender;
        message=this.mailSender.createMimeMessage();
        messageHelper = new MimeMessageHelper(message,"UTF-8");
    }

    public void setSubject(String subject) throws Exception {
        messageHelper.setSubject(subject);
    }

    public void setText(String htmlContent) throws Exception {
        messageHelper.setText(htmlContent, true);
    }

    public void setFrom(String email, String name) throws Exception {
        messageHelper.setFrom(email, name);
    }

    public void setTo(String email) throws Exception {
        messageHelper.setTo(email);
    }

    public void addInline(String contentId, DataSource dataSource) throws Exception {
        messageHelper.addInline(contentId,dataSource);
    }

    public void send() {
        mailSender.send(message);
    }
}
