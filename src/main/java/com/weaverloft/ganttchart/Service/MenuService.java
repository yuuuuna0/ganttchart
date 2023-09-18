package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Menu;

import java.util.List;

public interface MenuService {
    List<Menu> findMenuList() throws Exception;

    List<Menu> findAdminMenuList() throws Exception;

    List<Menu> findUserMenuList() throws Exception;

    List<Menu> findSellerMenuList() throws Exception;
}
