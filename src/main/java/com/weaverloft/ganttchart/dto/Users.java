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
    private int grade;
    private String password;
    private String name;
    private String photo;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;
    private int gender;
    private String phone;
    private String address;
    private String email;
    private int authStatus;
    private String authKey;
}
