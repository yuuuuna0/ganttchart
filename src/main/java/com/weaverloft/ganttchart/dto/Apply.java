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
public class Apply {
    private int applyNo;
    private Date applyDate;
    private String mId;
    private int gathNo;
    private int applyStatusNo;
}
