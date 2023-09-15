package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.City;

import java.util.List;

public interface CityDao {
    List<City> findCityList() throws Exception;

    City findCityByNo(int cityNo) throws Exception;
}
