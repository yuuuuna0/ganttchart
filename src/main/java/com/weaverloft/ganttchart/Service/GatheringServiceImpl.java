package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.CityDao;
import com.weaverloft.ganttchart.dao.FilesDao;
import com.weaverloft.ganttchart.dao.GatheringDao;
import com.weaverloft.ganttchart.dao.GatheringTypeDao;
import com.weaverloft.ganttchart.dto.Files;
import com.weaverloft.ganttchart.dto.Gathering;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GatheringServiceImpl implements GatheringService{
    private GatheringDao gatheringDao;
    private FilesDao filesDao;
    private CityDao cityDao;
    private GatheringTypeDao gatheringTypeDao;

    public GatheringServiceImpl(GatheringDao gatheringDao, FilesDao filesDao,CityDao cityDao,GatheringTypeDao gatheringTypeDao) {

        this.gatheringDao = gatheringDao;
        this.filesDao = filesDao;
        this.cityDao = cityDao;
        this.gatheringTypeDao = gatheringTypeDao;
    }

    @Override
    public List<Gathering> findGathList() throws Exception {
        List<Gathering> gatheringList = new ArrayList<>();
        List<Gathering> gatherings = gatheringDao.findGathList();

        for(int i=0;i<gatherings.size();i++){
            //gathering에 fileList 붙이기
            Gathering gathering = gatherings.get(i);
            List<Files> filesList = filesDao.findFileByGathNo(gathering.getGathNo());
            //city 붙이기?
            if(filesList.size() != 0) {
                gathering.setFilesList(filesList);
            }
            gatheringList.add(gathering);
        }
        return gatheringList;
    }


    @Override
    public Gathering findGathByNo(int gathNo) throws Exception {
        Gathering gathering = gatheringDao.findGathByNo(gathNo);
        gathering.setFilesList(filesDao.findFileByGathNo(gathNo));
        gathering.setCity(cityDao.findCityByNo(gathering.getCityNo()));
        gathering.setGatheringType(gatheringTypeDao.findGathTypeByNo(gathering.getGathTypeNo()));
        return gathering;
    }

    @Override
    public int createGath(Gathering gathering) throws Exception {
        return gatheringDao.createGath(gathering);
    }

    @Override
    public int findCurNo() throws Exception {
        return gatheringDao.findCurNo();
    }

    @Override
    public int updateGath(Gathering gathering) throws Exception {
        return gatheringDao.updateGath(gathering);
    }

    @Override
    public int updateGathStatusNo(int gathNo, int gathStatusNo) throws Exception {
        return gatheringDao.updateGathStatusNo(gathNo,gathStatusNo);
    }

    @Override
    public int deleteGath(int gathNo) throws Exception {
        return gatheringDao.deleteGath(gathNo);
    }

    @Override
    public int increaseReadCount(int gathNo) throws Exception {
        return gatheringDao.increaseReadCount(gathNo);
    }
}
