package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.City;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CityMapper {
    List<City> findCityList() throws Exception;

    City findCityByNo(int cityNo) throws Exception;
}
