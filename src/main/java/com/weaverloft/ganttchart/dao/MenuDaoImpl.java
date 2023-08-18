package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.mapper.MenuMapper;
import org.springframework.stereotype.Repository;

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
    public Menu findMenuByNo(int menuNo) throws Exception{
        return menuMapper.findMenuByNo(menuNo);
    }
}
