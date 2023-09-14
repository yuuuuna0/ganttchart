package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@Component
@AllArgsConstructor
@NoArgsConstructor
public class Files {
    private int fileNo;
    private String saveName;
    private String originalName;
    private String filePath;
    private String fileExt;
    private String isUse;
}
