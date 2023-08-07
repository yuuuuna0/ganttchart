package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dto.Users;

public interface UsersService {
    //1. 회원가입
    int createUsers(Users users) throws Exception;
    //1-1. 비밀번호 유효성 검증
    String isValidPassword(String password) throws Exception;
    //2. 내 정보 조회
    Users findUsersById(String id) throws Exception;
    //3. 정보 수정
    int updateUsers(Users users) throws Exception;
    //4. 회원 탈퇴
    int deleteUsers(String id) throws Exception;
    //5. 비밀번호 변경
    int updatePassword(String id, String password, String email) throws Exception;
    //6. 로그인
    Users login(String id,String password) throws Exception;
    //7. 아이디 찾기
    int findUsersByIdEmail(String id, String email) throws Exception;
}
