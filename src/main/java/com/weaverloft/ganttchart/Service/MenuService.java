package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Menu;

public interface MenuService {
    //1. 메뉴 작성하기
    int createMenu(Menu menu) throws Exception;
    //2. 메뉴번호로 메뉴 찾기
    Menu findMenuByNo(int menuNo) throws Exception;
}
