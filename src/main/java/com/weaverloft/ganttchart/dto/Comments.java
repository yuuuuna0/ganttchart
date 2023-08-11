package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comments {
    private int commnetsNo;
    private String commentsContent;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private LocalDateTime commentsDate;
    private int boardNo;
    private String id;

    //댓글, 대댓글 구분을 위한 컬럼
    private int classNo;    //계층번호  --> 댓글의 계층과 대댓글의 계층 구분
    private int orders;      //댓글,대댓글 순서 --> 댓글과 대댓글 순서대로 출력할 수 있도록
    private int groupNo;    //댓글 그룹 --> 대댓글이 댓글에 종속되어있음을 표시
}
