package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApplyStatus {
    /*
    0: 신청 대기중
    1: 수락
    2: 거절
     */
    private int applyStatusNo;
    private String applyStatus;
}
