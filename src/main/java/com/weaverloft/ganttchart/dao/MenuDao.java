package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;

import java.util.List;

public interface MenuDao {
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

    int updateMenuAuth(int menuNo, String auth) throws Exception;

    int deleteMenu(int menuNo) throws Exception;

    int countMenu(String keyword) throws Exception;

    List<Menu> findMenuList2(int contentBegin, int contentEnd, String keyword, String filterType, String ascDesc) throws Exception;
}
