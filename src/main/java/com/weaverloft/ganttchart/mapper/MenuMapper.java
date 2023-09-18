package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Menu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MenuMapper {
    List<Menu> findMenuList() throws Exception;

    List<Menu> findAdminMenuList() throws Exception;

    List<Menu> findUserMenuList() throws Exception;

    List<Menu> findSellerMenuList() throws Exception;
}
