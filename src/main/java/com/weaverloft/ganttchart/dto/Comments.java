package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comments {
    private int commnetsNo;
    private String commentsContent;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private LocalDateTime commentsDate;
    private int boardNo;
    private String id;

}
