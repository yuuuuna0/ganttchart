package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UsersServiceImpl implements UsersService{
    private UsersDao usersDao;

    public UsersServiceImpl(UsersDao usersDao) {
        this.usersDao=usersDao;
    }

    @Override
    //1. 회원가입
    public int createUsers(Users users) throws Exception {
        int result;
        try{
            //비밀번호 유효성 검증
            isValidPassword(users.getPassword());
        } catch (Exception e){
            e.getMessage();
        }
        result=usersDao.createUsers(users);
        return result;
    }
    /*
    1-1. 비밀번호 유효성 검증
    1) 8~15글자
    2) 영어, 숫자, 특수문자 포함
    3) 공백 안됨
    4)
     */
    public String isValidPassword(String password){
        //정규식 검사 객체
        Matcher matcher;
        //영어, 숫자, 특수문자 포함한 min~max 글자 정규식
        final String REGEX= "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,15}$";
        //공백 문자 정규식
        final String BLANKPT="(\\s)";

        if(password == null || password.isEmpty()){
            //입력한 내용이 없을 경우
            return "문자를 입력하세요";
        } else if(password.length()<8 || password.length()>15){
            //8~15글자의 비밀번호
            return "비밀번호는 8글자 이상 15글자 이하입니다.";
        } else if(password.matches(REGEX)){
            //영문, 숫자, 특수문자 포함 확인
            return "비밀번호는 영문, 숫자, 특수문자를 모두 포함해야 합니다.";
        } else if(Pattern.compile(BLANKPT).matcher(password).find()){
            //공백 포함된 경우
            return "비밀번호에는 공백이 포함될 수 없습니다.";
        } else{
            //성공
            return "사용 가능한 비밀번호입니다.";
        }
    }

    @Override
    //2. 내 정보 조회
    public Users findUsersById(String id) throws Exception {
        Users users=usersDao.findUsersById(id);
        return users;
    }

    @Override
    //3. 정보 수정
    public int updateUsers(Users users) throws Exception {
        int result;
        result=usersDao.updateUsers(users);
        return result;
    }

    @Override
    //4. 회원 탈퇴
    public int deleteUsers(String id) throws Exception {
        int result;
        result=usersDao.deleteUsers(id);
        return result;
    }

    @Override
    //5. 비밀번호 변경
    public int updatePassword(String id, String password, String email) throws Exception {
        int result;
        result=usersDao.updatePassword(id,password,email);
        return result;
    }

    @Override
    //6. 로그인
    public Users login(String id, String password) throws Exception {
        Users users=usersDao.findUsersById(id);
        if(users==null){
            System.out.println(users.getId()+"는 존재하지 않는 아이디입니다");
        }
        return users;
    }

    @Override
    //7. 아이디 찾기
    public int findUsersByIdEmail(String id, String email) throws Exception {
        return 0;
    }
}
