package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.util.PageMakerDto;

import java.util.List;

public interface MenuService {
    //1. 메뉴 작성하기
    int createMenu(Menu menu) throws Exception;
    //2. 메뉴번호로 메뉴 찾기
    Menu findMenuByNo(int menuNo) throws Exception;
    //3. 메뉴 삭제하기
    int deleteMenu(int menuNo) throws Exception;
    //4. 메뉴리스트 전체 불러오기
    PageMakerDto<Menu> findMenuList(int pageNo) throws Exception;
}
