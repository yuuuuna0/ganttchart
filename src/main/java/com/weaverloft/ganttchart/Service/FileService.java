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

@Service
public class FileService {
    String fileName;  //파일명
    String fileNameCutExt;  //확장자 제외한 파일명
    String fileExt;     //파일 확장자명

    //파일업로드 후 파일 이름 반환
    public String uploadFile(MultipartFile mFile,String filePath) throws Exception{
        System.out.println("mFile = " + mFile);
        if(mFile.isEmpty()){
            System.out.println("들어온 파라미터가 음슴");
            return null;
        }

        fileName = mFile.getOriginalFilename();
        fileExt = fileName.substring(fileName.lastIndexOf(".")+1);
        fileNameCutExt = fileName.substring(0,fileName.lastIndexOf("."));

        //파일명이 중복되었을 경우, 사용할 스트링 객체
        String saveFileName = "";
        String saveFilePath="";
        //"저장될 경로/파일명" ---> File.separator="/"
        saveFilePath=filePath + File.separator + fileName;
        //filePath에 해당되는 파일의 File객체를 생성
        File fileFolder = new File(filePath);
        if(!fileFolder.exists()){   //경로에 폴더 생성(부모폴더까지 포함해서)
            if(fileFolder.mkdirs()) {
                System.out.println("file.mkdirs() 생성 성공");
            }
        }
        File saveFile= new File(saveFilePath);

        if(saveFile.isFile()){   //saveFile이 File이면 true, 아니면 false
            //파일명이 중복일경우파일명(1).확장자, 파일명(2).확장자와 같은 형태로 생성
            boolean _exist=true;
            int index=0;

            //동일한 파일명이 존재하지 않을때까지 반복한다.
            while(_exist){
                index++;
                saveFileName = fileNameCutExt+"("+index+")."+fileExt;
                String dicFile = filePath+ File.separator+saveFileName;
                _exist = new File(dicFile).isFile();
                if(!_exist){
                    saveFilePath=dicFile;
                }
            }
            //생성한 파일 객체를 업로드 처리하지 않으면 임시 파일에 저장된 파일이 자동적으로 삭제되기 때문에 transferTo(File f) 메소드를 이용해서 업로드처리
            mFile.transferTo(new File(saveFilePath));
        } else{
            mFile.transferTo(saveFile);
        }
        return fileName;
    }
}


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

