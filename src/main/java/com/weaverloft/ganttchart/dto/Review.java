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
public class Review {
    private int reviewNo;
    private String reviewContent;
    private Date reviewDate;
    private String mId;
    private int gathNo;
    private List<Integer> ufileNo;
    private int groupNo;
    private int orders;
    private int depth;
}
