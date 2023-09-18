package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Files;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface FilesService {
    int findCurFileNo() throws Exception;

    Map<String,Object> uploadFile(MultipartFile file, int fileType) throws Exception;
    int createFile(Files file, int fileType) throws Exception;

    Files findFileByNo(int fileNo) throws Exception;

    List<Files> findFileByBoardNo(int boardNo) throws Exception;
    List<Files> findFileByReviewNo(int reviewNo) throws Exception;
    List<Files> findFileByGathNo(int gathNo) throws Exception;
}
