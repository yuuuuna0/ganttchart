package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.FilesDao;
import com.weaverloft.ganttchart.dto.Files;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    public Map<String,Object> uploadFile(MultipartFile file, int fileType) throws Exception {
        Map<String,Object> fileNameMap = new HashMap<>();
        String originalName = file.getOriginalFilename();
        String fileExt = fileExt(originalName);
        String saveName = saveName(originalName,fileExt);
        String filePath="";
        switch(fileType){
            case 1: //프로필 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\user\\";
                break;
            case 2: //모임사진 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\gathering\\";
                break;
            case 3: //후기사진 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\review\\";
                break;
            case 4: //게시글 파일 업로드
                filePath = "C:\\home\\01.Project\\01.InteliJ\\ganttchart\\src\\main\\webapp\\resources\\upload\\board\\";
                break;
        }
        File folder = new File(filePath);
        if(!folder.exists()){   //폴더 없을 경우
            folder.mkdirs();
        }
        //서버 업로드
        file.transferTo(new File(filePath+saveName));
        //필요한 정보들 map에 담아주기
        fileNameMap.put("saveName",saveName);
        fileNameMap.put("originalName",originalName);
        fileNameMap.put("filePath",filePath);
        fileNameMap.put("fileExt",fileExt);
        fileNameMap.put("fileSize",file.getSize());
        return fileNameMap;
    }

    @Override
    public int createFile(Files file, int fileType) throws Exception {
        return filesDao.createFile(file,fileType);
    }


    @Override
    public Files fineFileByNo(int fileNo) throws Exception {
        return filesDao.findFileByNo(fileNo);
    }

    @Override
    public List<Files> findFileByBoardNo(int boardNo) throws Exception {
        return filesDao.findFileByBoardNo(boardNo);
    }

    @Override
    public List<Files> findFileByReviewNo(int reviewNo) throws Exception {
        return filesDao.findFileByReviewNo(reviewNo);
    }

    @Override
    public List<Files> findFileByGathNo(int gathNo) throws Exception {
        return filesDao.findFileByGathNo(gathNo);
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
