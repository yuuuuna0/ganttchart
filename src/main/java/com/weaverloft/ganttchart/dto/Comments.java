package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@Component
@AllArgsConstructor
@NoArgsConstructor
public class Comments {
    private int commentsNo;
    private String commentsContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date commentsDate;
    private String uId;
    private int boardNo;
    private int groupNo;
    private int orders;
    private int depth;
}
