package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardFile {
    private int fileNo;
    private String saveFileName;
    private String originFileName;
    private String filePath;
    private String fileSize;
    private int boardNo;
}
