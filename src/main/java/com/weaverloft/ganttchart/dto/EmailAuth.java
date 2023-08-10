package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmailAuth {
    private String id;
    private String authKey;
    private int mailType;   // 아이디찾기:1 비밀번호찾기:2
}
