package com.weaverloft.ganttchart.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Data
@Component
@AllArgsConstructor
@NoArgsConstructor
public class Users {
    private String uId;
    private String uPassword;
    private String uName;
    private String uEmail;
    private String uGender;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date uBirth;
    private String uPhone;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date uCreateDate;
    private String uAddress;
    private String uAddress2;
    private int uStatusNo;
    private int fileNo;
    private String uAuthCode;
    private int enabled;

    private Files file;
    private List<Authorities> authList;
}
