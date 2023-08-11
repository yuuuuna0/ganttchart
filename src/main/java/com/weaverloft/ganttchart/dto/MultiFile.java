package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MultiFile {
    private int fileNo;
    private String fileName;
    private String fileExtension;
    private String fileSrc;
    private int boardNo;
}
