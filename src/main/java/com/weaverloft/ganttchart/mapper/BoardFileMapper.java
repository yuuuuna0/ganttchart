package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.BoardFile;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardFileMapper {
    //1. 게시글 파일 넣기
    int createBoardFile(BoardFile boardFile) throws Exception;
    //2. 게시글번호로 파일 전부 찾기
    List<BoardFile> findByBoardNo(int boardNo) throws Exception;
    //3. 파일번호로 파일 찾기
    BoardFile findFileByNo(int fileNo) throws Exception;
    //4. 파일번호로 파일 삭제
    int deleteFile(int fileNo) throws  Exception;
}
