package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.mapper.UsersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsersDaoImpl implements UsersDao {
    @Autowired
    private UsersMapper usersMapper;

    public UsersDaoImpl() {
        System.out.println("UserDaoImpl 기본 생성자 호출");
    }

    @Override
    //1. 회원가입
    public int createUsers(Users users) throws Exception {
        return usersMapper.createUsers(users);
    }

    @Override
    //2. 내 정보 조회
    public Users findUsersById(String id) throws Exception {
        return usersMapper.findUsersById(id);
    }

    @Override
    //3. 정보 수정
    public int updateUsers(Users users) throws Exception {
        return usersMapper.updateUsers(users);
    }

    @Override
    //4. 회원 탈퇴
    public int deleteUsers(String id) throws Exception {
        return usersMapper.deleteUsers(id);
    }

    @Override
    //5. 비밀번호 변경
    public int updatePassword(String id, String password, String email) throws Exception {
        return usersMapper.updatePassword(id,password,email);
    }

    @Override
    //6. 비밀번호 일치 확인
    public int isMatchPassword(String id, String password) throws Exception {
        return usersMapper.isMatchPassword(id,password);
    }

    @Override
    //7. 아이디 중복 체크
    public int isExistedId(String id) throws Exception {
        return usersMapper.isExistedId(id);
    }

    @Override
    //8. 이메일, 이름으로 회원 존재 여부 확인
    public int isExistedUsersByIdEmail(String id, String email) throws Exception {
        return usersMapper.isExistedUsersByIdEmail(id,email);
    }

}
