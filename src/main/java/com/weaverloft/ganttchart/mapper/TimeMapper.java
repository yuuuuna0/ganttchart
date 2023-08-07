package com.weaverloft.ganttchart.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TimeMapper {
    @Select("select sysdate from dual")
    public String getTime1();

    public String getTime2();
}
