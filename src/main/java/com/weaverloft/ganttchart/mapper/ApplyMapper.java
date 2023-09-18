package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Apply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ApplyMapper {
    int createApply(Apply apply) throws Exception;

    List<Apply> findApplyList() throws Exception;

    List<Apply> findApplyByGathNo(int gathNo) throws Exception;

    List<Apply> findApplyByUId(String uId) throws Exception;

    int changeApplyStatusNo(Map<String,Object> map) throws Exception;
    int countAcceptedApply(int gathNo) throws Exception;
}
