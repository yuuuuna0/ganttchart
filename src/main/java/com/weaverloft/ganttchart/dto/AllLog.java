package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class AllLog {
    private int logNo;
    private int logType;
    private Date logDate;
    private String uId;
    private int gathNo;
    private int uStatusNo;
    private int gathStatusNo;
}
