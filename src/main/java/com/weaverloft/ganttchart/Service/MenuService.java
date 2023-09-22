package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.SearchDto;

import java.util.List;

public interface MenuService {
    List<Menu> findMenuList() throws Exception;

    List<Menu> findAdminMenuList() throws Exception;

    List<Menu> findUserMenuList() throws Exception;

    List<Menu> findSellerMenuList() throws Exception;

    int createMenu(Menu menu) throws Exception;

    int createSubMenu(Menu menu) throws Exception;

    int countMenuByparentId(int parentId) throws Exception;

    int findCurNo() throws Exception;

    Menu findMenuByNo(int menuNo) throws Exception;

    int updateMenu(Menu menu) throws Exception;

    int updateMenuUType(int menuNo, int uTypeNo) throws Exception;

    int deleteMenu(int menuNo) throws Exception;

    SearchDto<Menu> findSearchedMenuList(int pageNo, String keyword, String filterType, String ascDesc) throws Exception;
}
