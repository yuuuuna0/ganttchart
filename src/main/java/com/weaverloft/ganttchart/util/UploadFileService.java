package com.weaverloft.ganttchart.util;

import com.weaverloft.ganttchart.Service.UfileService;
import com.weaverloft.ganttchart.dto.Ufile;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;


@Service
public class UploadFileService {
    private UfileService ufileService;

    public UploadFileService(UfileService ufileService) {
        this.ufileService = ufileService;
    }

    //1. 파일 저장 이름 만들기
    private String createSaveFileName(String originalFileName) {
        String ext = extractExt(originalFileName);
        String uuid = UUID.randomUUID().toString();
        return uuid + "." + ext;
    }

    //2. 확장자명 구하기
    private String extractExt(String originalFilename) {
        int pos = originalFilename.lastIndexOf(".");
        return originalFilename.substring(pos + 1);
    }

    //3. fullPath 만들기
    private String getFullPath(String filename, String filePath) {
        //filePath에 해당되는 File객체 생성
        File fileFolder = new File(filePath);
        if (!fileFolder.exists()) {   //경로에 폴더 생성(부모폴더까지 포함해서)
            if (fileFolder.mkdirs()) {
                System.out.println("file.mkdirs() 생성 성공");
            }
        }
        return filePath + filename;
    }

    public Ufile uploadFile(MultipartFile mFile, int ufileTypeNo) throws Exception {
        //1. DB에 저장할 파일 정보
        String originalUfileName = mFile.getOriginalFilename();  //원본 파일명
        String saveUfileName = createSaveFileName(originalUfileName); //저장 파일명(난수)
        String ufileExt = extractExt(originalUfileName);    //확장자명
        String filePath = ufileService.findUfilePath(ufileTypeNo);
        Ufile ufile = new Ufile(0,saveUfileName,originalUfileName,ufileExt,ufileTypeNo,0,"",0,0);

        //2, 서버에 파일 저장
        mFile.transferTo(new File(getFullPath(saveUfileName, filePath)));

        return ufile;
    }

}

