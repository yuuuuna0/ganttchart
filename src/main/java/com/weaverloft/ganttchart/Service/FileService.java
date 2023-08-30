package com.weaverloft.ganttchart.Service;

import org.springframework.aop.scope.ScopedProxyUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

@Service
public class FileService {


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

    public String uploadFile(MultipartFile mFile, String filePath) throws Exception {
        //1. DB에 저장할 파일 정보
        String originalFileName = mFile.getOriginalFilename();  //원본 파일명
        String saveFileName = createSaveFileName(originalFileName); //저장 파일명(난수)

        //2, 서버에 파일 저장
        mFile.transferTo(new File(getFullPath(saveFileName, filePath)));

        return saveFileName;


    }


}
































//
//    //2. 파일업로드 후 저장이름 반환
//    public String uploadFile(MultipartFile mFile, String filePath) throws Exception {
//        //1) 파일 없으면
//        if (mFile.isEmpty()) {
//            System.out.println("들어온 파라미터가 음슴");
//            return null;
//        }
//
//        //2) 파일 있으면
//        originalFileName = mFile.getOriginalFilename();
//        fileExt = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);  //originalFile없으면 nullpointexception 발생
//        saveFileName = createSaveFileName(originalFileName);    //저장명 난수로 설정
//
//        //"저장될 경로/파일명" ---> File.separator="/"
//        String saveFilePath = filePath + File.separator + originalFileName;
//
//        //filePath에 해당되는 File객체 생성
//        File fileFolder = new File(filePath);
//        if (!fileFolder.exists()) {   //경로에 폴더 생성(부모폴더까지 포함해서)
//            if (fileFolder.mkdirs()) {
//                System.out.println("file.mkdirs() 생성 성공");
//            }
//        }
//        File saveFile = new File(saveFilePath);
//
//        if (saveFile.isFile()) {   //saveFile이 File이면 true, 아니면 false
//            //생성한 파일 객체를 업로드 처리하지 않으면 임시 파일에 저장된 파일이 자동적으로 삭제되기 때문에 transferTo(File f) 메소드를 이용해서 업로드처리
//            mFile.transferTo(new File(saveFilePath));
//        } else {
//            mFile.transferTo(saveFile);
//        }
//        return saveFileName;
//    }






//        Map<String,Object> resultMap = new HashMap<>();
//        //키:파라미터이름 값:파라미터의 파일 정보를 값으로 하는 Map
//        Map<String, MultipartFile> files=multipartHttpServletRequest.getFileMap();
//        //files.entrySet()의 요소를 읽어온다
//        Iterator<Entry<String,MultipartFile>> itr=files.entrySet().iterator();
//        //MultipartFile 초기화
//        MultipartFile mFile;
//
//        //파일명이 중복되었을 경우, 사용할 스트링 객체
//        String saveFileName = "";
//        String saveFilePath="";
//        //읽어올 요소가 있으면 true, 없으면 false를 반환
//        while(itr.hasNext()){
//            Entry<String,MultipartFile> entry = itr.next();
//            //entry에 값을 가져온다.
//            mFile=entry.getValue();
//            //파일명, 확장자명, 확장자제외 파일명 설정
//            fileName = mFile.getOriginalFilename();
//            fileExt = fileName.substring(fileName.lastIndexOf(".")+1);
//            fileNameCutExt = fileName.substring(0,fileName.lastIndexOf("."));
//
//            //"저장될 경로/파일명" ---> File.separator="/"
//            saveFilePath=filePath + File.separator + fileName;
//            //filePath에 해당되는 파일의 File객체를 생성
//            File fileFolder = new File(filePath);
//            if(!fileFolder.exists()){   //경로에 폴더 생성(부모폴더까지 포함해서)
//                if(fileFolder.mkdirs()) {
//                    System.out.println("file.mkdirs() 생성 성공");
//                }
//            }
//

