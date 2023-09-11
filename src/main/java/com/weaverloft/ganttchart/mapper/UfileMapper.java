package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Ufile;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UfileMapper {
    // 파일 DB에 넣기
    //1-1. 프로필 넣기
    int createMUfile(Ufile ufile) throws Exception;
    //1-2. 모임사진 넣기
    int createGathUfile(Ufile ufile) throws Exception;
    //1-3. 후기사진 넣기
    int createReviewUfile(Ufile ufile) throws Exception;

    //2. 파일 비활성하기
    int updateUfileToNotUse(int ufileNo) throws Exception;
    //3. 파일 완전 삭제하기
    int deleteUfile(int ufileNo) throws Exception;

    //아래의 사진 가져올 때에는 isUse가 1인 것들만 가져와야한다.
    //4-1. 회원의 프로필사진 가져오기
    List<Ufile> findUfile(Map<String, Object> map) throws Exception;
//    //4-2. 모임의 사진리스트 가져오기
//    List<Ufile> findUfileListByGathNo(int gathNo) throws Exception;
//    //4-3. 후기의 사진리스트 가져오기
//    List<Ufile> findUfileListByReviewNo(int reviewNo) throws Exception;

    //5. 파일저장경로 가져오기
    String findUfilePath(int ufileTypeNo) throws Exception;
    //6. 최근 파일번호 불러오기
    int findCurNo() throws Exception;
}
