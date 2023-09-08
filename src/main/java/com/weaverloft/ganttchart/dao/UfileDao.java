package com.weaverloft.ganttchart.dao;


import com.weaverloft.ganttchart.dto.Ufile;

import java.util.List;

public interface UfileDao{
    // 파일 DB에 넣기
    //1-1. 프로필 넣기
    int createUfile(Ufile ufile) throws Exception;
//    //1-2. 모임사진 넣기
//    int createGathUFile(Ufile ufile) throws Exception;
//    //1-3. 후기사진 넣기
//    int createReviewUFile(Ufile ufile) throws Exception;

    //2. 파일 비활성하기
    int updateUfileToNotUse(int ufileNo) throws Exception;
    //3. 파일 완전 삭제하기
    int deleteUfile(int ufileNo) throws Exception;

    //아래의 사진 가져올 때에는 isUse가 1인 것들만 가져와야한다.
    //4-1. 회원의 프로필사진 가져오기
    List<Ufile> findUfile(String mId, int ufileTypeNo) throws Exception;
    List<Ufile> findUfile(int no, int ufileTypeNo) throws Exception;
    //4-2. 모임의 사진리스트 가져오기
//    List<Ufile> findUfileListByGathNo(int gathNo) throws Exception;
//    //4-3. 후기의 사진리스트 가져오기
//    List<Ufile> findUfileListByReviewNo(int reviewNo) throws Exception;

    //5. 파일저장경로 가져오기
    String findUfilePath(int ufileTypeNo) throws Exception;
}
