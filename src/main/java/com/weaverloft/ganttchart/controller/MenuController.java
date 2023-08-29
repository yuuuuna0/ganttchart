package com.weaverloft.ganttchart.controller;

import com.weaverloft.ganttchart.Service.MenuService;
import com.weaverloft.ganttchart.controller.Interceptor.AdminCheck;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/menu/*")
public class MenuController {
    private MenuService menuService;

    public MenuController(MenuService menuService) {
        this.menuService = menuService;
    }

    //1. 메뉴 만들기 페이지
    @AdminCheck
    @GetMapping("/register")
    public String menuCreate(Model model){
        String forwardPath = "";
        List<Menu> subMenuList = new ArrayList<>();

        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            forwardPath = "/menu/register";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
    //1-1. 메뉴(메뉴) 만들기 액션    //상위메뉴(parentId: null)
    @AdminCheck
    @PostMapping("/register-action")
    public String menuCreateAction(@ModelAttribute Menu menu){
        String forwardPath="";
        int result = 0;
        try{
            System.out.println("menu = " + menu);
            int menuOrder = menuService.findSubMenuList(menu.getParentId()).size();
            System.out.println("menuOrder = " + menuOrder);
            //1) 상위탭일 경우
            if(menu.getParentId() == 0 ){
                menu.setMenuOrder(menuOrder);
                result = menuService.createMenu(menu);
                int curNo = menuService.findCurMenuNo();
                menuService.updateParentId(curNo);
            }
            //2) 하위탭일경우
            if(menu.getParentId() != 0){
                menu.setMenuOrder(menuOrder); //parent거까지 +1 해줘야 함!!
                result = menuService.createSubMenu(menu);
            }
            forwardPath = "redirect:/menu/list/1";
        }catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }


    //2. 메뉴 상세보기 페이지
    @AdminCheck
    @GetMapping("/detail/{menuNo}")
    public String menuDetail(@PathVariable int menuNo,Model model){
        String forwardPath = "";
        List<Menu> subMenuList = new ArrayList<>();
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            Menu menu = menuService.findMenuByNo(menuNo);
            if(menu.getParentId() == 0){
                //상위탭이면 하위탭리스트 보여주기
                subMenuList = menuService.findSubMenuList(menu.getMenuNo());
                model.addAttribute("subMenuList",subMenuList);
            }
            if(menu.getParentId() != 0){
                //하위탭이면 상위탭만 보여주기
                Menu preMenu = menuService.findMenuByNo(menu.getParentId());
                model.addAttribute("preMenu",preMenu);
            }
            model.addAttribute("menu",menu);
            forwardPath = "/menu/detail";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    @AdminCheck
    @GetMapping("/modify/{menuNo}")
    public String menumodify(@PathVariable int menuNo, Model model){
        String forwardPath = "";
        List<Menu> subMenuList = new ArrayList<>();
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            Menu menu = menuService.findMenuByNo(menuNo);
            //상위탭이면 하위탭리스트 보여주기
//            if(menu.getMenuNo() == menu.getParentId()) --> 적용할지말지
            subMenuList = menuService.findSubMenuList(menu.getMenuNo());
            model.addAttribute("subMenuList",subMenuList);
            model.addAttribute("menu",menu);
            forwardPath = "/menu/modify";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    @AdminCheck
    @ResponseBody
    @PostMapping("/modify/submenu-ajax")
    public Map<String,Object> changeSubMenuAjax(@RequestParam int parentId){
        Map<String,Object> resultMap = new HashMap<>();
        int code =1;
        String msg = "성공";
        List<Menu> subMenuList= null;
        try{
            Menu menu = menuService.findMenuByNo(parentId);
            subMenuList = menuService.findSubMenuList(menu.getMenuNo());
        } catch (Exception e){
            e.printStackTrace();
            code = 2;
            msg = "실패";
        }
        resultMap.put("code",code);
        resultMap.put("msg",msg);
        resultMap.put("subMenuList",subMenuList);
        return resultMap;
    }

    //3-1. 메뉴 수정하기 액션
    @AdminCheck
    @PostMapping("/modify-action/{menuNo}")
    public String menuModifyAction(@PathVariable int menuNo, @ModelAttribute Menu menu) {
        String forwardPath = "";
        try{
            int result = menuService.updateMenu(menu);
            forwardPath = "redirect:/menu/detail/"+menu.getMenuNo();
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //3. 메뉴 전체리스트 불러오기
    @AdminCheck
    @GetMapping("/list")
    public String menuList(@RequestParam(required = false, defaultValue = "1") int pageNo,
                           @RequestParam(required = false, defaultValue = "") String keyword,  Model model){
        String forwardPath = "";
        try{
            //cm_left data
            Map<String, Object> map = menuService.cmLeftMenuList();
            model.addAttribute("menuList", map.get("menuList"));
            model.addAttribute("preMenuList",map.get("preMenuList"));

            PageMakerDto<Menu> menuListPage = menuService.findMenuList(pageNo,keyword);
            model.addAttribute("menuListPage",menuListPage);
            forwardPath = "/menu/list";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //4. 메뉴 삭제 액션
    @AdminCheck
    @GetMapping("delete-action")
    public String menuDeleteAction(@RequestParam int menuNo){
        String forwardPath = "";
        try{
            int result = menuService.deleteMenu(menuNo);
            forwardPath = "redirect:/menu/list/1";
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }

    //5. 메뉴 사용여부 변경 --> 리스트에서 쉽게 변경 가능하게 하기
    @AdminCheck
    @PostMapping("modifyUsing-action/{menuNo}")
    public String mofidyUsingAction(@PathVariable int menuNo, int useYN, int pageNo){
        String forwardPath ="";
        try {
            int resut = menuService.updateUse(menuNo,useYN);    //0:사용안함, 1: 사용함
            forwardPath = "redirect:/menu/list/"+pageNo;
        } catch (Exception e){
            e.printStackTrace();
        }
        return forwardPath;
    }
}
