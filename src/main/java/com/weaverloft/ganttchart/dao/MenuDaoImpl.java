package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.mapper.MenuMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MenuDaoImpl implements MenuDao{
    private MenuMapper menuMapper;

    public MenuDaoImpl(MenuMapper menuMapper) {
        this.menuMapper = menuMapper;
    }

    @Override
    public int createMenu(Menu menu) throws Exception{
        return menuMapper.createMenu(menu);
    }

    @Override
    public int createSubMenu(Menu menu) throws Exception{
        return menuMapper.createSubMenu(menu);
    }

    @Override
    public Menu findMenuByNo(int menuNo) throws Exception{
        return menuMapper.findMenuByNo(menuNo);
    }

    @Override
    public int deleteMenu(int menuNo) throws Exception{
        return menuMapper.deleteMenu(menuNo);
    }

    @Override
    public List<Menu> findMenuList(int pageBegin, int pageEnd) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("pageBegin",pageBegin);
        map.put("pageEnd",pageEnd);
        return menuMapper.findMenuList(map);
    }

    @Override
    public int findMenuCount() throws Exception{
        return menuMapper.findMenuCount();
    }

    @Override
    public int updateMenu(Menu menu) throws Exception{
        return menuMapper.updateMenu(menu);
    }

    @Override
    public int updateUse(int menuNo, int useYN)throws Exception {
        return menuMapper.updateUse(menuNo, useYN);
    }

    @Override
    public List<Menu> findSubMenuList(int menuNo) throws Exception {
        return menuMapper.findSubMenuList(menuNo);
    }

    @Override
    public List<Menu> findPreMenuList() throws Exception {
        return menuMapper.findPreMenuList();
    }
}
