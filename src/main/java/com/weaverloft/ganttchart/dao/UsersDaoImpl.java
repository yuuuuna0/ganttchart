package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.mapper.UsersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
    //2. 회원 조회
    public Users findUsersById(String id) throws Exception {
        return usersMapper.findUsersById(id);
    }
    //3. 비밀번호 일치 확인
    @Override
    public int isMatchPassword(String id, String password) throws Exception {
        return usersMapper.isMatchPassword(id,password);
    }
    //4. 아이디 중복 체크
    @Override
    public int isExistedId(String id) throws Exception {
        return usersMapper.isExistedId(id);
    }
    //5. 이미지 업로드
    @Override
    public int updateUsers(Users users) throws Exception {
        return usersMapper.updateUsers(users);
    }
    //6. 이메일 인증 후 인증확인으로 상태 변경 (isEmailAuth: 0->1)
    @Override
    public int updateAuthStatus1(String id) throws Exception{
        return usersMapper.updateAuthStatus1(id);
    }
    //6. 이메일 인증 후 인증확인으로 상태 변경 (isEmailAuth: 0->1)
    @Override
    public int updateAuthStatus2(String id) throws Exception{
        return usersMapper.updateAuthStatus2(id);
    }
    //7. 이름, 이메일로 아이디 찾기
    @Override
    public List<String> findIdByNameEmail(String name, String email) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        map.put("email",email);
        return usersMapper.findIdByNameEmail(map);
    }
    //8. 아이디, 이메일로 비밀번호 변경하기
    @Override
    public int findPasswordByIdNameEmail(String id, String name, String email) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        map.put("name",name);
        map.put("email",email);
        return usersMapper.findPasswordByIdNameEmail(map);
    }
    //9. 비밀번호 변경
    @Override
    public int updatePassword(String id, String password, int authStatus) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        map.put("password",password);
        map.put("authStatus", authStatus);
        return usersMapper.updatePassword(map);
    }
    @Override
    //10. 회원 탈퇴
    public int deleteUsers(String id) throws Exception {
        return usersMapper.deleteUsers(id);
    }

    @Override
    public int findUsersCount(String keyword) throws Exception{
        return usersMapper.findUsersCount(keyword);
    }

    @Override
    public List<Users> findUserList(int pageBegin, int pageEnd, String keyword) throws Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("pageBegin",pageBegin);
        map.put("pageEnd",pageEnd);
        map.put("keyword",keyword);
        return usersMapper.findUserList(map);
    }

    @Override
    public List<Users> findUserList() throws Exception {
        return usersMapper.findUserList2();
    }




    /*
    @Override
    //3. 정보 수정
    public int updateUsers(Users users) throws Exception {
        return usersMapper.updateUsers(users);
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
     */

}
