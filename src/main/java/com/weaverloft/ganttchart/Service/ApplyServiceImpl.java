package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.ApplyDao;
import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dto.Apply;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ApplyServiceImpl implements ApplyService{
    private ApplyDao applyDao;
    private UsersDao usersDao;

    public ApplyServiceImpl(ApplyDao applyDao,UsersDao usersDao) {
        this.applyDao = applyDao;
        this.usersDao = usersDao;
    }

    @Override
    public int createApply(Apply apply) throws Exception {
        return applyDao.createApply(apply);
    }

    @Override
    public List<Apply> findApplyList() throws Exception {
        return applyDao.findApplyList();
    }

    @Override
    public List<Apply> findApplyByGathNo(int gathNo) throws Exception {
        List<Apply> applies = applyDao.findApplyByGathNo(gathNo);
        List<Apply> applyList = new ArrayList<>();
        for(int i=0;i<applies.size();i++){
            Apply apply = applies.get(i);
            Users user = usersDao.findUserById(apply.getUId());
            apply.setUsers(user);
            applyList.add(apply);
        }
        return applyList;
    }

    @Override
    public List<Apply> findApplyByUId(String uId) throws Exception {
        List<Apply> applies = applyDao.findApplyByUId(uId);
        List<Apply> applyList = new ArrayList<>();
        for(int i=0;i<applies.size();i++){
            Apply apply = applies.get(i);
            Users user = usersDao.findUserById(apply.getUId());
            apply.setUsers(user);
            applyList.add(apply);
        }
        return applyList;
    }

    @Override
    public int changeApplyStatusNo(int applyNo, int applyStatusNo) throws Exception {
        return applyDao.changeApplyStatusNo(applyNo,applyStatusNo);
    }

    @Override
    public int countAcceptedApply(int gathNo) throws Exception {
        return applyDao.countAcceptedApply(gathNo);
    }

    @Override
    public boolean checkDuplication(int gathNo, String uId) throws Exception {
        return applyDao.checkDuplication(gathNo,uId);
    }

}
