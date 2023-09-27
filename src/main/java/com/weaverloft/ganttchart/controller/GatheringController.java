package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.*;
import com.weaverloft.ganttchart.controller.annotation.HostCheck;
import com.weaverloft.ganttchart.controller.annotation.LoginCheck;
import com.weaverloft.ganttchart.dto.*;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Date;
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
    private ApplyService applyService;
    private ReviewService reviewService;
    private MenuService menuService;

    public GatheringController(GatheringService gatheringService, FilesService filesService, CityService cityService,
                               UsersService usersService,GatheringTypeService gatheringTypeService,ApplyService applyService,
                               ReviewService reviewService,MenuService menuService) {
        this.gatheringService = gatheringService;
        this.filesService = filesService;
        this.cityService = cityService;
        this.usersService = usersService;
        this.gatheringTypeService = gatheringTypeService;
        this.applyService = applyService;
        this.reviewService = reviewService;
        this.menuService = menuService;
    }
    //메뉴리스트
    @ModelAttribute("menuList")
    public List<Menu> menuList() throws Exception{
        List<Menu> menuList = menuService.findMenuList();
        System.out.println("menuList = " + menuList);
        return menuList;
    }

    //1. 모임리스트 페이지
    @GetMapping(value = "/list")    // 
    public String listPage(Model model,
                           @RequestParam(required = false, defaultValue = "1") int pageNo,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String filterType,
                           @RequestParam(required = false) String ascDesc,
                           @RequestParam(required = false, defaultValue = "0") int cityNo,
                           @RequestParam(required = false, defaultValue = "0") int gathTypeNo,
                           @RequestParam(required = false, defaultValue = "0") int gathStatusNo){
        String forwardPath = "";
        try {
            SearchDto<Gathering> searchGathList = gatheringService.findSearchedGathList(pageNo,keyword,filterType,ascDesc,cityNo,gathTypeNo,gathStatusNo);
            List<Users> userList = usersService.findUserList();
            List<City> cityList = cityService.findCityList();
            List<GatheringType> gathTypeList = gatheringTypeService.findGathTypeList();
            model.addAttribute("searchGathList", searchGathList);
            model.addAttribute("userList",userList);
            model.addAttribute("cityList",cityList);
            model.addAttribute("gathTypeList",gathTypeList);
            //검색어, 필터링 넣어주기
            Map<String,Object> filterMap = new HashMap<>();
            filterMap.put("keyword",keyword);
            filterMap.put("cityNo",cityNo);
            filterMap.put("gathTypeNo",gathTypeNo);
            filterMap.put("gathStatusNo",gathStatusNo);
            model.addAttribute("filterMap",filterMap);
            forwardPath = "/gathering/list";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }

    //2. 모임 상세보기 페이지
    @GetMapping(value = "/detail")
    public String detailPage(@RequestParam int gathNo, Model model) {
        String forwardPath = "";
        try {
            Gathering gathering = gatheringService.findGathByNo(gathNo);
            List<Apply> applyList = applyService.findApplyByGathNo(gathNo);
            List<Review> reviewList = reviewService.findReviewByGathNo(gathNo);
            int acceptedPerson = applyService.countAcceptedApply(gathNo);
            System.out.println("acceptedPerson = " + acceptedPerson);
            gatheringService.increaseReadCount(gathNo);
            model.addAttribute("gath",gathering);
            model.addAttribute("applyList",applyList);
            model.addAttribute("reviewList",reviewList);
            model.addAttribute("acceptedPerson",acceptedPerson);
            System.out.println("gathering = " + gathering);
            forwardPath = "/gathering/detail";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 모임 수정하기 페이지
    @HostCheck
    @LoginCheck
    @GetMapping(value = "/modify")
    public String modifyPage(@RequestParam int gathNo,Model model){
        String forwardPath = "";
        try {
            Gathering gathering = gatheringService.findGathByNo(gathNo);
            List<City> cityList = cityService.findCityList();
            List<GatheringType> gathTypeList = gatheringTypeService.findGathTypeList();
            List<Files> fileList = filesService.findFileByGathNo(gathNo);
            model.addAttribute("cityList",cityList);
            model.addAttribute("gathTypeList",gathTypeList);
            model.addAttribute("gath",gathering);
            model.addAttribute("fileList",fileList);
            forwardPath = "/gathering/modify";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return forwardPath;
    }
    //3-1. 모임 수정하기 AJAX
    @HostCheck
    @LoginCheck
    @ResponseBody
    @PostMapping(value = "/modify.ajx")
    public Map<String, Object> modifyAjax(@RequestParam int gathNo, Gathering gathering, @RequestPart(required = false) List<MultipartFile> mfList
                                            ,@RequestParam(required = false)List<String> nameList){
        Map<String,Object> resultMap = new HashMap<>();
        int code = 0;
        String msg = "";
        String forwardPath ="";
        try{
            //1)기존파일(String으로 들어오는 파일) 현재 파일과 비교해서 없는건 isUse N으로 변경해야한다. --> 뭔가 코드가 이상함,,,,
            List<Files> extFileList = filesService.findFileByGathNo(gathNo);
            for (Files file:extFileList) {
                filesService.updateIsUse(file.getFileNo());
            }
            if(nameList.size() != 0) {
                for (int j = 0; j < nameList.size(); j++) {

                }
            }
            //2) 파일 업로드
            if(mfList != null){
                for(int i=0;i<mfList.size();i++){
                    MultipartFile mf = mfList.get(i);
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
    @HostCheck
    @LoginCheck
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
    @HostCheck
    @LoginCheck
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
    @HostCheck
    @LoginCheck
    @GetMapping(value = "/delete.action")
    public String deleteAction(@RequestParam int gathNo){
        String forwardPath = "";
        try{
            int result = gatheringService.updateGathStatusNo(gathNo,99);
            forwardPath="redirect:/gathering/list?pageNo=1&keyword=";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


    //6. 모임 신청하기
    @LoginCheck
    @ResponseBody
    @PostMapping(value = "/apply.ajx")
    public Map<String,Object> gathApplyPage(@RequestParam int gathNo, HttpSession session){
        Map<String,Object> resultMap = new HashMap<>();
        int code =0;
        String msg = "";
        try{
            Users loginUser = (Users)session.getAttribute("loginUser");
            Apply apply = new Apply(0,new Date(),loginUser.getUId(),gathNo,1,loginUser);
            //중복 신청 안되게 막는 메소드 필요함
            if(applyService.checkDuplication(gathNo,loginUser.getUId())){
                code=2;
                msg="이미 신청한 모임입니다.";
            } else{
                int result = applyService.createApply(apply);
                if(result == 1){
                    code=1;
                    msg="신청되었습니다.";
                }
            }
        } catch (Exception e){
            e.printStackTrace();
            code = 99;
            msg = "알 수 없는 오류가 발생하였습니다. 다시 시도해주세요";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        return resultMap;
    }





}
