package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Menu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MenuMapper {
    //1. 메뉴 작성하기
    int createMenu(Menu menu) throws Exception;
    //2. 메뉴번호로 메뉴 찾기
    Menu findMenuByNo(int menuNo) throws Exception;
    //3. 메뉴 삭제하기
    int deleteMenu(int menuNo);
    //4. 메뉴리스트 전체 불러오기
    List<Menu> findMenuList(Map<String,Object> map);
    //5. 전체 메뉴 개수
    int findMenuCount();
}