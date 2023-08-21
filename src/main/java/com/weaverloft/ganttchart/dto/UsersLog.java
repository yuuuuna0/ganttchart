package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UsersLog {
    private int logNo;
    private Date logDate;
    private int logStatus;      //0:가입완료 1:인증완료 5:회원탈퇴 / 10:로그인 11:로그아웃
    private String id;
}
