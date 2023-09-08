package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GatheringType {
    /*
    모임 카테고리 설정 DTO
     */
    private int gathTypeNo;
    private String gathType;
}
