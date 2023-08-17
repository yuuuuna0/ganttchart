package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.BoardFile;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardFileMapper {
    //1. 게시글 파일 넣기
    int createBoardFile(BoardFile boardFile) throws Exception;

    List<BoardFile> findByBoardNo(int boardNo) throws Exception;
}
