package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;
import org.apache.ibatis.annotations.Param;

public interface UsersDao {
    //1. 회원가입
    int createUsers(Users users) throws Exception;
    //2. 내 정보 조회
    Users findUsersById(String id) throws Exception;
    //3. 비밀번호 일치 확인
    int isMatchPassword(String id, String password) throws Exception;
    //4. 아이디 중복 체크
    int isExistedId(String id) throws Exception;
    //5. 이미지 업로드
    int updatePhoto(String id, String photo);


    /*
    //3. 정보 수정
    int updateUsers(Users users) throws Exception;
    //4. 회원 탈퇴
    int deleteUsers(String id) throws Exception;
    //5. 비밀번호 변경
    int updatePassword(String id, String password, String email) throws Exception;
    //6. 비밀번호 일치 확인
    int isMatchPassword(String id,String password) throws Exception;

    //8. 이메일, 이름으로 회원 존재 여부 확인
    int isExistedUsersByIdEmail(String id, String email) throws Exception;
     */
}
