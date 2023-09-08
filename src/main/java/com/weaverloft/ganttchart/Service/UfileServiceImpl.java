package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.UfileDao;
import com.weaverloft.ganttchart.dto.Ufile;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UfileServiceImpl implements UfileService{
    private UfileDao ufileDao;

    public UfileServiceImpl(UfileDao ufileDao) {
        this.ufileDao = ufileDao;
    }

    @Override
    public int createUfile(Ufile ufile) throws Exception {
        return ufileDao.createUfile(ufile);
    }

    @Override
    public int updateUfileToNotUse(int ufileNo) throws Exception {
        return ufileDao.updateUfileToNotUse(ufileNo);
    }

    @Override
    public int deleteUfile(int ufileNo) throws Exception {
        return ufileDao.deleteUfile(ufileNo);
    }

    @Override
    public List<Ufile> findUfile(int ufileTypeNo, String mId, int gathNo, int reviewNo) throws Exception {
        List<Ufile> list = new ArrayList<>();
        switch (ufileTypeNo) {
            case 1:
                list = ufileDao.findUfile(mId, ufileTypeNo);
                break;
            case 2:
                list = ufileDao.findUfile(gathNo, ufileTypeNo);
                break;
            case 3:
                list = ufileDao.findUfile(reviewNo, ufileTypeNo);
                break;
        }
        return list;
    }

    @Override
    public String findUfilePath(int ufileTypeNo) throws Exception {
        return ufileDao.findUfilePath(ufileTypeNo);
    }


}
