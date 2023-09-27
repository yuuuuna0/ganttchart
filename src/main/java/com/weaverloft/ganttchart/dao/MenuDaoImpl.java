package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.mapper.MenuMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MenuDaoImpl implements MenuDao {
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

    @Override
    public int createMenu(Menu menu) throws Exception {
        return menuMapper.createMenu(menu);
    }

    @Override
    public int createSubMenu(Menu menu) throws Exception {
        return menuMapper.createSubMenu(menu);
    }

    @Override
    public int countMenuByparentId(int parentId) throws Exception {
        return menuMapper.countMenuByparentId(parentId);
    }

    @Override
    public int findCurNo() throws Exception {
        return menuMapper.findCurNo();
    }

    @Override
    public Menu findMenuByNo(int menuNo) throws Exception {
        return menuMapper.findMenuByNo(menuNo);
    }

    @Override
    public int updateMenu(Menu menu) throws Exception {
        return menuMapper.updateMenu(menu);
    }

    @Override
    public int updateMenuAuth(int menuNo, String auth) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("menuNo",menuNo);
        map.put("auth",auth);
        return menuMapper.updateMenuAuth(map);
    }

    @Override
    public int deleteMenu(int menuNo) throws Exception {
        return menuMapper.deleteMenu(menuNo);
    }

    @Override
    public int countMenu(String keyword) throws Exception {
        return menuMapper.countMenu(keyword);
    }

    @Override
    public List<Menu> findMenuList2(int contentBegin, int contentEnd, String keyword, String filterType, String ascDesc) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("contentBegin",contentBegin);
        map.put("contentEnd",contentEnd);
        map.put("keyword",keyword);
        map.put("filterType",filterType);
        map.put("ascDesc",ascDesc);
        return menuMapper.findMenuList2(map);
    }

}
