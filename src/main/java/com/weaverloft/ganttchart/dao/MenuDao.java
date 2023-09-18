package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;

import java.util.List;

public interface MenuDao {
    List<Menu> findMenuList() throws Exception;

    List<Menu> findAdminMenuList() throws Exception;

    List<Menu> findUserMenuList() throws Exception;

    List<Menu> findSellerMenuList() throws Exception;
}
