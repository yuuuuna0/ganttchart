package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Files;
import org.springframework.web.multipart.MultipartFile;

public interface FilesService {
    int findCurFileNo() throws Exception;

    int createFile(MultipartFile file,int fileType) throws Exception;

    Files fineFileByNo(int fileNo) throws Exception;
}
