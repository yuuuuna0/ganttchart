package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Data
@Component
@NoArgsConstructor
@AllArgsConstructor
public class Gathering {
    private int gathNo;
    private String gathTitle;
    private String uId;
    private String gathAddr;
    private String gathAddr2;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date gathClose;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date gathDay;
    private String gathDesc;
    private int gathAmount;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date gathCreateDate;
    private int gathTypeNo;
    private int gathStatusNo;
    private int cityNo;
    private int gathReadcount;

    private List<Files> fileList;
    private City city;
    private GatheringType gatheringType;
    private Users user;

//    public Gathering(int gathNo, String gathTitle, String uId, String gathAddr, String gathAddr2, Date gathClose, Date gathDay, String gathDesc, int gathAmount, Date gathCreateDate, int gathTypeNo, int gathStatusNo, int gathReadCount) {
//        this.gathNo = gathNo;
//        this.gathTitle = gathTitle;
//        this.uId = uId;
//        this.gathAddr = gathAddr;
//        this.gathAddr2 = gathAddr2;
//        this.gathClose = gathClose;
//        this.gathDay = gathDay;
//        this.gathDesc = gathDesc;
//        this.gathAmount = gathAmount;
//        this.gathCreateDate = gathCreateDate;
//        this.gathTypeNo = gathTypeNo;
//        this.gathStatusNo = gathStatusNo;
//        this.gathReadCount = gathReadCount;
//    }
}
