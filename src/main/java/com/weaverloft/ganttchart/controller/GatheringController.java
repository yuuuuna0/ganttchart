package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.dto.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/gathering/*")
public class GatheringController {
    private GatheringService gatheringService;
    private FilesService filesService;
    private CityService cityService;
    private UsersService usersService;
    private GatheringTypeService gatheringTypeService;

    public GatheringController(GatheringService gatheringService, FilesService filesService, CityService cityService,
                               UsersService usersService,GatheringTypeService gatheringTypeService) {
        this.gatheringService = gatheringService;
        this.filesService = filesService;
        this.cityService = cityService;
        this.usersService = usersService;
        this.gatheringTypeService = gatheringTypeService;
    }

    //1. 모임리스트 페이지
    @GetMapping(value = "/list", params = {"pageNo","keyword"})
    public String listPage(Model model,@RequestParam(required = false, defaultValue = "1")int pageNo, @RequestParam(required = false, defaultValue = "")String keyword) {
        String forwardPath = "";
        try {
            List<Gathering> gatheringList = gatheringService.findGathList();
            List<Users> userList = usersService.findUserList();
            model.addAttribute("gatheringList", gatheringList);
            model.addAttribute("useList",userList);
            System.out.println("gatheringList = " + gatheringList);
            forwardPath = "/gathering/list";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }

    //2. 모임 상세보기 페이지
    @GetMapping(value = "/detail", params = "gathNo")
    public String detailPage(@RequestParam int gathNo, Model model) {
        String forwardPath = "";
        try {
            Gathering gathering = gatheringService.findGathByNo(gathNo);
            List<Files> fileList = filesService.findFileByGathNo(gathNo);
            gatheringService.increaseReadCount(gathNo);
            model.addAttribute("gath",gathering);
            model.addAttribute("fileList",fileList);
            System.out.println("gathering = " + gathering);
            forwardPath = "/gathering/detail";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 모임 수정하기 페이지
    @GetMapping(value = "/modify",params = "gathNo")
    public String modifyPage(@RequestParam int gathNo,Model model){
        String forwardPath = "";
        try {
            Gathering gathering = gatheringService.findGathByNo(gathNo);
            model.addAttribute("gathering",gathering);
            forwardPath = "/gathering/modify";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }
    //3-1. 모임 수정하기 AJAX
    @ResponseBody
    @PostMapping(value = "/modify.ajx",params = "gathNo")
    public Map<String, Object> modifyAjax(@RequestParam int gathNo, Gathering gathering, @RequestPart(required = false) List<MultipartFile> fileList
                                            /*,nameList?*/,List<String> nameList){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        try{
            //1)기존파일(String으로 들어오는 파일) 현재 파일과 비교해서 없는건 isUse N으로 변경해야한다. --> 너무 복잡?
            List<Files> extFileList = filesService.findFileByGathNo(gathNo);
            for(int i=0;i<extFileList.size();i++){
                Files file = extFileList.get(i);
                for(int j=0;j<nameList.size();j++){
                    if(!file.getOriginalName().equals(nameList.get(j))){
                        file.setIsUse("N");
                    }
                }
            }
            //2) 파일 업로드
            if(fileList != null){
                for(int i=0;i<fileList.size();i++){
                    MultipartFile mf = fileList.get(i);
                    Map<String,Object> map= filesService.uploadFile(mf,2);
                    Files file = new Files(0,
                            (String)map.get("saveName"),
                            (String)map.get("originalName"),
                            (String)map.get("filePath"),
                            (String)map.get("fileExt"),
                            "Y",
                            null,
                            gathNo,0,0,
                            (Long)map.get("fileSize"));
                    filesService.createFile(file,2);
                }
            }
            //3) 모임 업데이트
            int result = gatheringService.updateGath(gathering);
            if(result == 1){
                code = 1;
                forwardPath = "/gathering/detail?gathNo="+gathNo;
            }

        }catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //4. 모임 작성하기 페이지
    @GetMapping(value = "/register")
    public String registerPage(Model model){
        String forwardPath = "";
        try {
            List<City> cityList = cityService.findCityList();
            List<GatheringType> gathTypeList = gatheringTypeService.findGathTypeList();
            model.addAttribute("cityList",cityList);
            model.addAttribute("gathTypeList",gathTypeList);
            forwardPath = "/gathering/register";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }
    //4-1. 모임 작성하기 AJAX
    @ResponseBody
    @PostMapping("/register.ajx")
    public Map<String,Object> registerAjax(Gathering gathering, @RequestPart(required = false) List<MultipartFile> mfList, HttpSession session){ //map 안에 gathering 자동 맵핑되어서 gathering object 전달됨, 이외의 데이터들은 다른 key로 같이 넘어올거같음
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        try {
            Users user = (Users) session.getAttribute("loginUser");
            gathering.setUId(user.getUId());
            int result = gatheringService.createGath(gathering);
            int gathNo = gatheringService.findCurNo();
            if(mfList != null) {
                for (int i = 0; i < mfList.size(); i++) {
                    MultipartFile mf = mfList.get(i);
                    Map<String, Object> map = filesService.uploadFile(mf, 2);
                    Files file = new Files(0,
                            (String) map.get("saveName"),
                            (String) map.get("originalName"),
                            (String) map.get("filePath"),
                            (String) map.get("fileExt"),
                            "Y",
                            null,
                            gathNo, 0, 0,
                            (Long) map.get("fileSize"));
                    filesService.createFile(file, 2);
                }
          }
            if(result ==1){
                code = 1;
                forwardPath = "/gathering/detail?gathNo="+gathNo;
            }
        }catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("forwardPath",forwardPath);
        return resultMap;
    }
    //5. 모임 삭제하기 --> 상태변경으로 하는 것 / db 삭제는 아님
    @RequestMapping(value = "/delete.action", params = "gathNo")
    public String deleteAction(@RequestParam int gathNo){
        String forwardPath = "";
        try{
            int result = gatheringService.updateGathStatusNo(gathNo,99);
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }







}
