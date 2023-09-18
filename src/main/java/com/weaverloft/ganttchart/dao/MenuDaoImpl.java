package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.mapper.MenuMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MenuDaoImpl implements MenuDao{
    private MenuMapper menuMapper;

    public MenuDaoImpl(MenuMapper menuMapper) {
        this.menuMapper = menuMapper;
    }

    @Override
    public List<Menu> findMenuList() throws Exception {
        return menuMapper.findMenuList();
    }

    @Override
    public List<Menu> findAdminMenuList() throws Exception {
        return menuMapper.findAdminMenuList();
    }

    @Override
    public List<Menu> findUserMenuList() throws Exception {
        return menuMapper.findUserMenuList();
    }

    @Override
    public List<Menu> findSellerMenuList() throws Exception {
        return menuMapper.findSellerMenuList();
    }
}
