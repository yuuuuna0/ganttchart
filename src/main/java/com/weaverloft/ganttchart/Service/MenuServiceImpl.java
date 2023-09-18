package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.MenuDao;
import com.weaverloft.ganttchart.dto.Menu;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService{
    private MenuDao menuDao;

    public MenuServiceImpl(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    @Override
    public List<Menu> findMenuList() throws Exception {
        return menuDao.findMenuList();
    }

    @Override
    public List<Menu> findAdminMenuList() throws Exception {
        return menuDao.findAdminMenuList();
    }

    @Override
    public List<Menu> findUserMenuList() throws Exception {
        return menuDao.findUserMenuList();
    }

    @Override
    public List<Menu> findSellerMenuList() throws Exception {
        return menuDao.findSellerMenuList();
    }
}
