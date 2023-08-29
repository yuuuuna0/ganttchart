package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;

import java.util.List;

public interface MenuDao {
    //1-1. 메뉴 작성하기
    int createMenu(Menu menu) throws Exception;
    //1-2. 하위메뉴 작성하기
    int createSubMenu(Menu menu) throws Exception;
    //2. 메뉴번호로 메뉴 찾기
    Menu findMenuByNo(int menuNo) throws Exception;
    //3. 메뉴 삭제하기
    int deleteMenu(int menuNo) throws Exception;
    //4. 메뉴리스트 전체 불러오기
    List<Menu> findMenuList(int pageBegin, int pageEnd,String keyword) throws Exception;
    //5. 전체 메뉴 개수
    int findMenuCount(String keyword) throws Exception;
    //6. 메뉴 업데이트하기
    int updateMenu(Menu menu) throws Exception;
    //7. 사용여부 변경하기
    int updateUse(int menuNo, int useYN) throws Exception;
    //8. 하위메뉴리스트 불러오기
    List<Menu> findSubMenuList(int menuNo) throws Exception;
    //9. 상위메뉴리스트 불러오기
    List<Menu> findPreMenuList() throws Exception;
    //10. 메뉴전체 불러오기
    List<Menu> findAllMenu() throws  Exception;
    //11. 최근 값 불러오기
    int findCurMenuNo() throws Exception;
    //12. 상위메뉴 parentId 부여하기
    int updateParentId(int menuNo) throws Exception;
    //14. 메뉴이름 존재개수
    int isExistedMenuTitle(String menuTitle);
    //15. 메뉴url 존재여부 확인
    int isExistedMenuUrl(String menuUrl);
}
