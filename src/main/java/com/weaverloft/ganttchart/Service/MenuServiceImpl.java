package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.MenuDao;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public int createSubMenu(Menu menu) throws Exception{
        return menuDao.createSubMenu(menu);
    }

    @Override
    public Menu findMenuByNo(int menuNo) throws Exception{
        return menuDao.findMenuByNo(menuNo);
    }

    @Override
    public int deleteMenu(int menuNo) throws Exception{
        return menuDao.deleteMenu(menuNo);
    }

    @Override
    public PageMakerDto<Menu> findMenuList(int pageNo) throws Exception{
        int totMenuCount = menuDao.findMenuCount();
        PageMaker pageMaker = new PageMaker(totMenuCount,pageNo);
        List<Menu> menuList = menuDao.findMenuList(pageMaker.getPageBegin(),pageMaker.getPageEnd());
        PageMakerDto<Menu> pageMakerMenuList = new PageMakerDto<>(menuList,pageMaker,totMenuCount);
        return pageMakerMenuList;
    }

    @Override
    public int updateMenu(Menu menu) throws Exception{
        return menuDao.updateMenu(menu);
    }

    @Override
    public int updateUse(int menuNo, int useYN) throws Exception{
        return menuDao.updateUse(menuNo, useYN);
    }

    @Override
    public List<Menu> findSubMenuList(int menuNo) throws Exception {
        return menuDao.findSubMenuList(menuNo);
    }

    @Override
    public List<Menu> findPreMenuList() throws Exception {
        return menuDao.findPreMenuList();
    }

    @Override
    public List<Menu> findAllMenu() throws Exception {
        return menuDao.findAllMenu();
    }

    @Override
    public int findCurMenuNo() throws Exception {
        return menuDao.findCurMenuNo();
    }

    @Override
    public int updateParentId(int menuNo) throws Exception {
        return menuDao.updateParentId(menuNo);
    }

}
