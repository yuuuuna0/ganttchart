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
@AllArgsConstructor
@NoArgsConstructor
public class Review {
    private int reviewNo;
    private String reviewContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date reviewDate;
    private String uId;
    private int gathNo;
    private int reviewRating;
    private List<Files> fileList;
}
