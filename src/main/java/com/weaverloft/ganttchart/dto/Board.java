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
public class Board {
    private int boardNo;
    private String boardTitle;
    private String boardContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date boardDate;
    private int boardReadcount;
    private String uId;
}
