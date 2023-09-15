package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.City;

import java.util.List;

public interface CityService {
    List<City> findCityList() throws Exception;
}
