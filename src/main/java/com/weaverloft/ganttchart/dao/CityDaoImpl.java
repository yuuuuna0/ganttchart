package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.City;
import com.weaverloft.ganttchart.mapper.CityMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CityDaoImpl implements CityDao {
    private CityMapper cityMapper;

    public CityDaoImpl(CityMapper cityMapper) {
        this.cityMapper = cityMapper;
    }

    @Override
    public List<City> findCityList() throws Exception {
        return cityMapper.findCityList();
    }

    @Override
    public City findCityByNo(int cityNo) throws Exception {
        return cityMapper.findCityByNo(cityNo);
    }
}