package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Ufile {
    private int ufileNo;
    private String saveUfileName;
    private String originalUfileName;
    private String ufileExt;
    private int ufileTypeNo;
    private int isUse;  //0:사용 1: 사용안함
    private String mId;
    private int gathNo;
    private int reviewNo;
}
