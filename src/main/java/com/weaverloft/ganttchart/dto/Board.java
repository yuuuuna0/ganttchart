package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import oracle.sql.DATE;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
    private int boardNo;
    private String boardTitle;
    private String boardContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date boardDate;
    private List<String> boardFileList;
    private String id;
    private int boardReadcount;
}
