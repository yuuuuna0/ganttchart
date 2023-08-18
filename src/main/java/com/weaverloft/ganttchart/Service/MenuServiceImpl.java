package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.MenuDao;
import com.weaverloft.ganttchart.dto.Menu;
import org.springframework.stereotype.Service;

@Service
public class MenuServiceImpl implements MenuService {
    private MenuDao menuDao;

    public MenuServiceImpl(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    @Override
    public int createMenu(Menu menu) throws Exception{
        return menuDao.createMenu(menu);
    }

    @Override
    public Menu findMenuByNo(int menuNo) throws Exception{
        return menuDao.findMenuByNo(menuNo);
    }
}
