package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Files;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FilesMapper {
    int findCurFileNo() throws Exception;

    int createUserFile(Files files) throws Exception;
    int createGathFile(Files files) throws Exception;
    int createReviewFile(Files files) throws Exception;
    int createBoardFile(Files files) throws Exception;

    Files findFileByNo(int fileNo) throws Exception;

    List<Files> findFileByBoardNo(int boardNo) throws Exception;
    List<Files> findFileByReviewNo(int reviewNo) throws Exception;
    List<Files> findFileByGathNo(int gathNo) throws Exception;
}
