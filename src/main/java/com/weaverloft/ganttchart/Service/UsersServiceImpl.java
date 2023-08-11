package com.weaverloft.ganttchart.Service;


import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.exception.PasswordMismatchException;
import com.weaverloft.ganttchart.exception.UserNotFoundException;
import com.weaverloft.ganttchart.exception.isInvalidPasswordException;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UsersServiceImpl implements UsersService {
    private UsersDao usersDao;

    public UsersServiceImpl(UsersDao usersDao) {
        System.out.println("UserServiceImpl 생성");
        this.usersDao = usersDao;
    }

    //1. 로그인
    @Override
    public Users login(String id, String password) throws Exception {
        Users users = usersDao.findUsersById(id);
        if (users == null) {
            throw new UserNotFoundException("존재하지 않는 아이디입니다.");
        }
        if (!users.getPassword().equals(password)) {
            //저장된 비밀번호와 암호화된 비밀번호를 비교
            throw new PasswordMismatchException("비밀번호가 일치하지 않습니다.");
        }
        return users;
    }


    @Override
    //2. 회원가입
    public int createUsers(Users users) throws Exception {
        int result = usersDao.createUsers(users);
        return result;
    }

    //3. 비밀번호 정규식 체크
    @Override
    public boolean isValidPassword(String password) throws Exception {
        /*
          1) 8~15글자
          2) 영어, 숫자, 특수문자 포함
          3) 공백 안됨
        */
        Matcher matcher;    //정규식 검사 객체
        final String REGEX = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,15}$";     //영어, 숫자, 특수문자 포함한 min~max 글자 정규식
        final String BLANKPT = "(\\s)";       //공백 문자 정규식

        if (password == null || password.isEmpty()) {
            //입력한 내용이 없을 경우
            System.out.println("문자를 입력하세요");
            return false;
        } else if (password.length() < 8 || password.length() > 15) {
            //8~15글자의 비밀번호
            System.out.println("비밀번호는 8글자 이상 15글자 이하여야합니다.");
            return false;
        } else if (password.matches(REGEX)) {
            //영문, 숫자, 특수문자 포함 확인
            System.out.println("비밀번호는 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
            return false;
        } else if (Pattern.compile(BLANKPT).matcher(password).find()) {
            //공백 포함된 경우
            System.out.println("비밀번호에는 공백이 포함될 수 없습니다.");
            return false;
        } else {
            //성공
            System.out.println("사용 가능한 비밀번호입니다.");
            return true;
        }
    }

    //4. 아이디 중복 확인
    @Override
    public Users findUsersById(String id) throws Exception {
        Users users = usersDao.findUsersById(id);    //0:중복X, 1: 중복O
        return users;
    }

    //5. 정보 업데이트
    @Override
    public int updateUsers(Users users) throws Exception {
        int result = usersDao.updateUsers(users);
        return result;
    }

    //6. 이메일 인증 후 인증확인으로 상태 변경 (isEmailAuth: 0->1)
    @Override
    public int updateAuthStatus(String id, int authStatus) throws Exception {
        int result = usersDao.updateAuthStatus(id, authStatus);
        return result;
    }

    //7. 이름,이메일로 아이디 찾기
    @Override
    public String findIdByNameEmail(String name, String email) throws Exception {
        String findId = usersDao.findIdByNameEmail(name, email);
        return findId;
    }

    //8. 아이디, 이메일로 비밀번호 변경하기
    @Override
    public int findPasswordByIdEmail(String id, String email) throws Exception {
        int result = usersDao.findPasswordByIdEmail(id, email);
        return result;
    }

    //9. 비밀번호 변경
    @Override
    public int updatePassword(String id, String encryptTempPassword) throws Exception {
        int result = usersDao.updatePassword(id, encryptTempPassword);
        return 0;
    }
    @Override
    //10. 회원 탈퇴
    public int deleteUsers(String id) throws Exception {
        int result;
        result=usersDao.deleteUsers(id);
        return result;
    }















    /*
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
            System.out.println(id+"는 존재하지 않는 아이디입니다");
        }
        if(!password.equals(users.getPassword())){
            System.out.println("비밀번호가 일치하지 않습니다.");
        }
        return users;
    }

    @Override
    //7. 아이디 찾기
    public String findUsersByIdEmail(String id, String email) throws Exception {
        int result;
        result=usersDao.isExistedUsersByIdEmail(id,email);
        if(result == 0){
            System.out.println("회원이 존재하지 않습니다.");
        }
        return id;
    }
    */
}
