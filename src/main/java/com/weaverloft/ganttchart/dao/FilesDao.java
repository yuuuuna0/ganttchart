package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Files;

import java.util.List;

public interface FilesDao {
    int findCurFileNo() throws Exception;

    int createFile(Files files, int fileType) throws Exception;

    Files findFileByNo(int fileNo) throws Exception;

    List<Files> findFileByBoardNo(int boardNo) throws Exception;
    List<Files> findFileByReviewNo(int reviewNo) throws Exception;
    List<Files> findFileByGathNo(int gathNo) throws Exception;

    int updateIsUse(int fileNo) throws Exception;
}
