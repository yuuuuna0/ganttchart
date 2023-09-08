package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Gathering {
    private int gathNo;
    private String gathName;
    private String gathAddr;
    private String gathAddr2;
    private long gathLang;
    private long gathLong;
    private Date gathClose;
    private Date gathDay;
    private String gathDesc;
    private int gathCount;
    private Date gathRegiDate;
    private int gathTypeNo;
    private List<Integer> ufileNoList;
    private int gathStatusNo;
    private int cityNo;
}
