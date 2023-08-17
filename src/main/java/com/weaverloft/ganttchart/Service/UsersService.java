package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.util.PageMakerDto;

public interface UsersService {
    //1. 로그인
    Users login(String id,String password) throws Exception;
    //2. 회원가입
    int createUsers(Users users) throws Exception;
    //3. 비밀번호 정규식 체크
    boolean isValidPassword(String password) throws Exception;
    //4. 회원조회
    Users findUsersById(String id) throws Exception;
    //5. 정보 업데이트
    int updateUsers(Users users) throws Exception;
    //6. 이메일 인증 후 인증확인으로 상태 변경 (isEmailAuth: 0->1)
    int updateAuthStatus(String id) throws Exception;
    //7. 이름,이메일로 아이디 찾기
    String findIdByNameEmail(String name, String email) throws Exception;
    //8. 아이디, 이름, 이메일로 비밀번호 변경하기
    int findPasswordByIdNameEmail(String id, String name, String email) throws Exception;
    //9. 비밀번호 변경
    int updatePassword(String id, String encryptTempPassword) throws Exception;
    //10. 회원 탈퇴
    int deleteUsers(String id) throws Exception;
    //11. 회원 전체 조회 --> 페이징
    PageMakerDto findUserList(int pageNo, String keyword) throws Exception;
    //12. 회원리스트 엑셀
    void userListExcelDown(Users users,int pageNo, String keyword) throws Exception;

    /*
    //2. 내 정보 조회
    Users findUsersById(String id) throws Exception;
    //3. 정보 수정
    int updateUsers(Users users) throws Exception;

    //5. 비밀번호 변경
    int updatePassword(String id, String password, String email) throws Exception;
    //6. 로그인
    Users login(String id,String password) throws Exception;
    //7. 아이디 찾기
    String findUsersByIdEmail(String id, String email) throws Exception;
     */
}
