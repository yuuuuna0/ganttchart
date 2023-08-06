package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Users;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UsersMapper {
    //1. 회원가입
    int createUsers(Users users) throws Exception;
    //2. 내 정보 조회
    Users findUsersById(String id) throws Exception;
    //3. 정보 수정
    Users updateUsers(Users users) throws Exception;
    //4. 회원 탈퇴
    int deleteUsers(String id) throws Exception;
}
