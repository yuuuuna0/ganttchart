package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UfileType {
    /*
    1: 사용자 프로필사진 (1장)
    2: 모임 게시글 사진 (여러장)
    3: 모임후기 사진 (여러장)
     */
    private int ufileTypeNo;
    private String ufileType;
    private String ufilePath;
}
