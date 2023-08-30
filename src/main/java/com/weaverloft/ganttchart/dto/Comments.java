package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comments {
    private int commentsNo;
    private String commentsContent;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date commentsDate;
    //댓글, 대댓글 구분을 위한 컬럼
    private int orders;      //댓글,대댓글 순서 --> 댓글과 대댓글 순서대로 출력할 수 있도록
    private int groupNo;    //댓글 그룹 --> 대댓글이 댓글에 종속되어있음을 표시
    private int boardNo;
    private String id;

}
