package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.CityDao;
import com.weaverloft.ganttchart.dto.City;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CityServiceImpl implements CityService{
    private CityDao cityDao;

    public CityServiceImpl(CityDao cityDao) {
        this.cityDao = cityDao;
    }

    @Override
    public List<City> findCityList() throws Exception {
        return cityDao.findCityList();
    }
}
