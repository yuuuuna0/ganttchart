package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.FilesDao;
import com.weaverloft.ganttchart.dto.Files;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

@Service
public class FilesServiceImpl implements FilesService{
    private FilesDao filesDao;

    public FilesServiceImpl(FilesDao filesDao) {
        this.filesDao = filesDao;
    }

    @Override
    public int findCurFileNo() throws Exception {
        return filesDao.findCurFileNo();
    }

    @Override
    public int createFile(MultipartFile file,int fileType) throws Exception {
        String originalName = file.getOriginalFilename();
        String fileExt = fileExt(originalName);
        String saveName = saveName(originalName,fileExt);
        String filePath="";
        switch(fileType){
            case 1: //프로필 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\user\\";
                break;
            case 2: //모임사진 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\gathering";
                break;
            case 3: //후기사진 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\review";
                break;
            case 4: //게시글 파일 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\board";
                break;
        }
        File folder = new File(filePath);
        if(!folder.exists()){   //폴더 없을 경우
            folder.mkdirs();
        }
        //서버 업로드
        file.transferTo(new File(filePath+saveName));
        //db업데이트
        Files files = new Files(0,saveName,originalName,filePath,fileExt,"Y");
        int result = filesDao.createFile(files);
        return result;
    }

    @Override
    public Files fineFileByNo(int fileNo) throws Exception {
        return filesDao.findFileByNo(fileNo);
    }

    //1. 파일 확장자
    private String fileExt(String originalName){
        int index = originalName.lastIndexOf(".");
        return originalName.substring(index+1);
    }
    //2. 파일저장이름 -> 난수
    private String saveName(String originalName,String fileExt){
        String uuid = UUID.randomUUID().toString();
        return uuid+"."+fileExt;
    }
}
