package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@Component
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private int menuNo;
    private int parentId;
    private int orders;
    private String menuTitle;
    private String menuUrl;
    private String menuDesc;
    private int uTypeNo;
}
