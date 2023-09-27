package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.MenuDao;
import com.weaverloft.ganttchart.dto.Menu;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.SearchDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {
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

    @Override
    public int createMenu(Menu menu) throws Exception {
        return menuDao.createMenu(menu);
    }

    @Override
    public int createSubMenu(Menu menu) throws Exception {
        return menuDao.createSubMenu(menu);
    }

    @Override
    public int countMenuByparentId(int parentId) throws Exception {
        return menuDao.countMenuByparentId(parentId);
    }

    @Override
    public int findCurNo() throws Exception {
        return menuDao.findCurNo();
    }

    @Override
    public Menu findMenuByNo(int menuNo) throws Exception {
        return menuDao.findMenuByNo(menuNo);
    }

    @Override
    public int updateMenu(Menu menu) throws Exception {
        return menuDao.updateMenu(menu);
    }

    @Override
    public int updateMenuAuth(int menuNo, String auth) throws Exception {
        return menuDao.updateMenuAuth(menuNo,auth);
    }

    @Override
    public int deleteMenu(int menuNo) throws Exception {
        return menuDao.deleteMenu(menuNo);
    }

    @Override
    public SearchDto<Menu> findSearchedMenuList(int pageNo, String keyword, String filterType, String ascDesc) throws Exception {
        //조건에 맞는 전체 사용자 수
        int totMenuCount = menuDao.countMenu(keyword);
        //페이지네이션에 필요한 변수들 얻기
        PageMaker pageMaker = new PageMaker(totMenuCount,pageNo);
        //페이징&필터된 데이터 얻기
        List<Menu> menuList = menuDao.findMenuList2(pageMaker.getContentBegin(),pageMaker.getContentEnd(),keyword,filterType,ascDesc);
        SearchDto<Menu> searchMenuList = new SearchDto<Menu>(menuList,pageMaker,totMenuCount);
        return searchMenuList;
    }

}
