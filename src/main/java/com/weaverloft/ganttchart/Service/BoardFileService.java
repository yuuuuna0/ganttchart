package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.BoardFile;

import java.util.List;

public interface BoardFileService {
    int createBoardFile(BoardFile boardFile) throws Exception;
    //게시글번호로 파일리스트 찾기
    List<BoardFile> findByBoardNo(int boardNo) throws Exception;
    //3. 파일번호로 파일 찾기
    BoardFile findFileByNo(int fileNo) throws Exception;
}
