package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GatheringStatus {
    /*
    0: 모집중
    1: 인원마감
    2: 모집일 마감
    3: 모임 완료
    99: 모임 삭제
     */
    private int gathStatusNo;
    private String gathStatus;
}
