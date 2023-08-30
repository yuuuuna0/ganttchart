package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UsersDao {
    //1. 회원가입
    int createUsers(Users users) throws Exception;
    //2. 회원 조회
    Users findUsersById(String id) throws Exception;
    //3. 비밀번호 일치 확인
    int isMatchPassword(String id, String password) throws Exception;
    //4. 아이디 중복 체크
    int isExistedId(String id) throws Exception;
    //5. 정보 수정
    int updateUsers(Users users) throws Exception;
    //6. 이메일 인증 후 인증확인으로 상태 변경 (isEmailAuth: 0->1)
    int updateAuthStatus1(String id) throws Exception;
    //6. 휴면상태로 변경 (2)
    int updateAuthStatus2(String id) throws Exception;
    //7. 이름, 이메일로 아이디 찾기
    List<String> findIdByNameEmail(String name, String email) throws Exception;
    //8. 아이디, 이름, 이메일로 비밀번호 변경하기
    int findPasswordByIdNameEmail(String id, String name, String email) throws Exception;
    //9. 비밀번호 변경
    int updatePassword(String id, String encryptTempPassword, int authStatus) throws Exception;
    //10. 회원 탈퇴
    int deleteUsers(String id) throws Exception;
    //11. 전체회원 수
    int findUsersCount(String keyword) throws Exception;
    //12. 회원리스트 -> 페이징,검색
    List<Users> findUserList(int pageBegin, int pageEnd, String keyword) throws Exception;
    //14. 모든 유저 찾기
    List<Users> findAllUsers();

    /*
    //3. 정보 수정
    int updateUsers(Users users) throws Exception;

    //5. 비밀번호 변경
    int updatePassword(String id, String password, String email) throws Exception;
    //6. 비밀번호 일치 확인
    int isMatchPassword(String id,String password) throws Exception;

    //8. 이메일, 이름으로 회원 존재 여부 확인
    int isExistedUsersByIdEmail(String id, String email) throws Exception;
     */
}
