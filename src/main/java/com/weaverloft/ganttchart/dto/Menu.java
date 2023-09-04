package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private int menuNo;
    private int menuOrder;
    private String menuTitle;
    private String menuUrl;
    private String menuDesc;
    private int parentId;
    private int useYN;   // 0:공개 1: 비공개
}
