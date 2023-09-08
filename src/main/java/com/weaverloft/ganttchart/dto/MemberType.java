package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberType {
    /*
    0: 관리자
    1: 일반회원
    2: 판매자(주최자)
     */
    private int mTypeNo;
    private String mType;
}
