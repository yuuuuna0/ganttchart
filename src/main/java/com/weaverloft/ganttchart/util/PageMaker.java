package com.weaverloft.ganttchart.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageMaker {
    public static final int CONTENT_SCALE = 3; //한 페이지 게시글 수
    public static final int BLOCK_SCALE = 5;    //한 페이지 블록 수
    private int totCount;                       //전체 게시글 수
    private int totPage;                        //전체 페이지 수
    private int curPage;                        //현재페이지
    private int prevPage;
    private int nextPage;
    private int blockBegin;                     //화면상 첫번째 블록번호
    private int blockEnd;                       //화면상 마지막 블록번호
    private int curBlockGroup;                  //현재 페이지 그룹
    private int contentBegin;                   //현재 페이지 컨텐트 시작번호
    private int contentEnd;                     //현재체이지 컨텐트 끝번호
    private int prevBlockBegin;
    private int nextBlockBegin;

    public PageMaker(int totalCount, int curPage){
        this.curPage = curPage;
        this.totCount = totalCount;
        this.totPage = (int) Math.ceil(totCount*1.0/CONTENT_SCALE);
        this.curBlockGroup = (int)Math.ceil(curPage*1.0/BLOCK_SCALE);
        this.blockBegin = (curBlockGroup-1)*5+1;
        this.blockEnd = curBlockGroup*5;
        if(blockEnd > totPage){
            this.blockEnd = totPage;
        }
        this.contentBegin = (curPage-1)*CONTENT_SCALE+1;
        this.contentEnd = contentBegin + CONTENT_SCALE -1;
        this.prevBlockBegin = blockBegin - BLOCK_SCALE;
        this.nextBlockBegin = blockEnd + BLOCK_SCALE;
        if(nextBlockBegin >= totPage){
            nextBlockBegin = totPage;
        }
    }

}
