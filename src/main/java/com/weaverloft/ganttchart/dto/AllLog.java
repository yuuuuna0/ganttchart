package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AllLog {
    /*

     */
    private int logNo;
    private int logType;
    private Date logDate;
    private String mId;
    private int gathNo;
    private int mStatusNo;
    private int gathStatusNo;
}
