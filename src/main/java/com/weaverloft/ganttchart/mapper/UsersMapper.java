package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Users;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface UsersMapper {
    //1. 회원가입
    int createUsers(Users users) throws Exception;
    //2. 회원 조회
    Users findUsersById(String id) throws Exception;
    //3. 정보 수정
    int updateUsers(Users users) throws Exception;
    //4. 비밀번호 일치 확인
    int isMatchPassword(String id, String password) throws Exception;
    //5. 아이디 중복 체크
    int isExistedId(String id) throws Exception;
    //6. 이름, 이메일로 아이디 찾기
    String findIdByNameEmail(Map<String,Object> map) throws Exception;
    //7. 이메일인증 업데이트
    int updateAuthStatus(Map<String,Object> map) throws Exception;
    //8. 이미지 업로드
    int updatePhoto(String id, String photo);
    //9. 아이디, 이메일로 비밀번호 변경하기
    int findPasswordByIdEmail(Map<String,Object> map) throws Exception;
    //10. 비밀번호 변경
    int updatePassword(Map<String,Object> map) throws Exception;
    //11. 회원 탈퇴
    int deleteUsers(String id) throws Exception;
}
