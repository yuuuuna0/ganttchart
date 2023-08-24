package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Users {
    private String id;
    private int grade;      //관리자:0 일반회원:1
    private String password;
    private String name;
    private String photo;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;
    private int gender;     //남:1 여:2
    private String phone;
    private String address;
    private String email;
    private int authStatus;     //인증 전:0 인증 후:1
    private String authKey;
    private Date createDate;
}
