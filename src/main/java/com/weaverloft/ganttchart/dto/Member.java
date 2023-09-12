package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
    private String mId;
    private String mPassword;
    private String mName;
    private String mEmail;
    private String mGender;
    private String mPhone;
    private Date mRegiDate;
    private Date mExDate;
    private String mAddr;
    private String mAddr2;
    private int mTypeNo;
    private int mStatusNo;
    private String mAuthCode;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date mBirth;

}
