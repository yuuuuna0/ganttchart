package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.CityDao;
import com.weaverloft.ganttchart.dao.FilesDao;
import com.weaverloft.ganttchart.dao.GatheringDao;
import com.weaverloft.ganttchart.dao.GatheringTypeDao;
import com.weaverloft.ganttchart.dto.Files;
import com.weaverloft.ganttchart.dto.Gathering;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.SearchDto;
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
            List<Files> fileList = filesDao.findFileByGathNo(gathering.getGathNo());
            //city 붙이기?
            if(fileList.size() != 0) {
                gathering.setFileList(fileList);
            }
            gatheringList.add(gathering);
        }
        return gatheringList;
    }


    @Override
    public Gathering findGathByNo(int gathNo) throws Exception {
        Gathering gathering = gatheringDao.findGathByNo(gathNo);
        gathering.setFileList(filesDao.findFileByGathNo(gathNo));
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

    @Override
    public int changeGathStatusByTime() throws Exception {
        return gatheringDao.changeGathStatusByTime();
    }

    @Override
    public List<Gathering> findTopNGath(int index) throws Exception {
        return gatheringDao.findTopNGath(index);
    }

    @Override
    public List<Gathering> findNearGath() throws Exception {
        return gatheringDao.findNearGath();
    }

    @Override
    public List<Gathering> findGathByUId(String uId) throws Exception {
        return gatheringDao.findGathByUId(uId);
    }

    @Override
    public SearchDto<Gathering> findSearchedGathList(int pageNo, String keyword, String filterType, String ascDesc) throws Exception {
        //조건에 맞는 전체 사용자 수
        int totGathCount = gatheringDao.countGath(keyword);
        //페이지네이션에 필요한 변수들 얻기
        PageMaker pageMaker = new PageMaker(totGathCount,pageNo);
        //페이징&필터된 데이터 얻기
        List<Gathering> gatheringList = gatheringDao.findGathList2(pageMaker.getContentBegin(),pageMaker.getContentEnd(),keyword,filterType,ascDesc);
        List<Gathering> gathList = new ArrayList<>();

        for(int i=0;i<gatheringList.size();i++){
            //gathering에 fileList 붙이기
            Gathering gathering = gatheringList.get(i);
            List<Files> fileList = filesDao.findFileByGathNo(gathering.getGathNo());
            //city 붙이기?
            if(fileList.size() != 0) {
                gathering.setFileList(fileList);
            }
            gathList.add(gathering);
        }
        SearchDto<Gathering> searchGathList = new SearchDto<Gathering>(gathList,pageMaker,totGathCount);
        return searchGathList;
    }

}
