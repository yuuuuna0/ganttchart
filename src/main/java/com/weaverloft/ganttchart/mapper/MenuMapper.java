package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Menu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MenuMapper {
    List<Menu> findMenuList() throws Exception;

    List<Menu> findAdminMenuList() throws Exception;

    List<Menu> findUserMenuList() throws Exception;

    List<Menu> findSellerMenuList() throws Exception;

    int createMenu(Menu menu) throws Exception;

    int createSubMenu(Menu menu) throws Exception;

    int countMenuByparentId(int parentId) throws Exception;

    int findCurNo() throws Exception;

    Menu findMenuByNo(int menuNo) throws Exception;

    int updateMenu(Menu menu) throws Exception;

    int updateMenuUType(Map<String, Object> map) throws Exception;

    int deleteMenu(int menuNo) throws Exception;

    int countMenu(String keyword) throws Exception;

    List<Menu> findMenuList2(Map<String, Object> map) throws Exception;
}
