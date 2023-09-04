package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Menu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MenuMapper {
    //1. 상위 메뉴 작성하기
    int createMenu(Menu menu) throws Exception;
    //1-1. 하위 메뉴 작성하기
    int createSubMenu(Menu menu) throws Exception;
    //2. 메뉴번호로 메뉴 찾기
    Menu findMenuByNo(int menuNo) throws Exception;
    //3. 메뉴 삭제하기
    int deleteMenu(int menuNo) throws Exception;
    //4. 메뉴리스트 전체 불러오기
    List<Menu> findMenuList(Map<String,Object> map);
    //5. 전체 메뉴 개수
    int findMenuCount(String keyword) throws Exception;
    //6. 메뉴 수정하기
    int updateMenu(Menu menu) throws Exception;
    //7. 사용여부 변경하기
    int updateUse(Map<String,Object> map) throws Exception;
    //8. 하위메뉴리스트 불러오기
    List<Menu> findSubMenuList(int menuNo) throws Exception;
    //9. 상위메뉴리스트 불러오기
    List<Menu> findPreMenuList() throws Exception;
    //10. 메뉴전체 불러오기
    List<Menu> findAllMenu() throws  Exception;
    //10. 사용중인 메뉴 전체 불러오기
    List<Menu> findUseMenu() throws  Exception;
    //11. 최근 값 불러오기
    int findCurMenuNo() throws Exception;
    //12. 상위메뉴 parentId 부여하기
    int updateParentId(int menuNo) throws Exception;
    //14. 메뉴이름 존재개수
    int isExistedMenuTitle(String menuTitle) throws Exception;
    //15. 메뉴url 존재여부 확인
    int isExistedMenuUrl(String menuUrl) throws Exception;
}
