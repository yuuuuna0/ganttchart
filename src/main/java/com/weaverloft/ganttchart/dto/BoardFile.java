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
    private String originalFileName;
    private String filePath;
    private Long fileSize;
    private int boardNo;
}
