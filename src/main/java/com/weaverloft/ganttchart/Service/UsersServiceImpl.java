package com.weaverloft.ganttchart.Service;


import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dto.Users;
import com.weaverloft.ganttchart.exception.PasswordMismatchException;
import com.weaverloft.ganttchart.exception.UserNotFoundException;
import com.weaverloft.ganttchart.exception.isInvalidPasswordException;
import com.weaverloft.ganttchart.util.PageMaker;
import com.weaverloft.ganttchart.util.PageMakerDto;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UsersServiceImpl implements UsersService {
    private UsersDao usersDao;
    private HttpSession session;

    public UsersServiceImpl(UsersDao usersDao, HttpSession session) {
        System.out.println("UserServiceImpl 생성");
        this.usersDao = usersDao;
        this.session = session;
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
    public int updateAuthStatus(String id) throws Exception {
        int result = usersDao.updateAuthStatus(id);
        return result;
    }

    //7. 이름,이메일로 아이디 찾기
    @Override
    public String findIdByNameEmail(String name, String email) throws Exception {
        String findId = usersDao.findIdByNameEmail(name, email);
        return findId;
    }

    //8. 아이디, 이름, 이메일로 비밀번호 변경하기
    @Override
    public int findPasswordByIdNameEmail(String id, String name, String email) throws Exception {
        int result = usersDao.findPasswordByIdNameEmail(id, name, email);
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
        result = usersDao.deleteUsers(id);
        return result;
    }

    //11. 회원 전체 조회
    @Override
    public PageMakerDto findUserList(int pageNo, String keyword) throws Exception {
        int totUserCount = usersDao.findUsersCount();
        PageMaker pageMaker = new PageMaker(totUserCount, pageNo);
        List<Users> userList = usersDao.findUserList(pageMaker.getPageBegin(), pageMaker.getPageEnd(), keyword);
        PageMakerDto<Users> pageMakerUserList = new PageMakerDto<Users>(userList, pageMaker, totUserCount);
        return pageMakerUserList;
    }

    @Override
    public void userListExcelDown(Users users, int pageNo, String keyword) throws Exception {
        int totUserCount = usersDao.findUsersCount();
        PageMaker pageMaker = new PageMaker(totUserCount, pageNo);
//        if(){
//          //전체 출력하는 경우 keyword == null && pagNo는?
//        }
        List<Users> usersList = usersDao.findUserList(pageMaker.getPageBegin(), pageMaker.getPageEnd(), keyword);   //선택된 페이지 or 키워드의 유저만 담김

        //엑셀 만들기
        try {
            //Excel Down 시작
            Workbook workbook = new HSSFWorkbook();
            //시트생성
            Sheet sheet = workbook.createSheet("***_관리");
            //행, 열, 열번호
            Row row = null;
            Cell cell = null;
            int rowNo = 0;

            // 테이블 헤더용 스타일
            CellStyle headStyle = workbook.createCellStyle();
            // 가는 경계선을 가집니다.
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
            // 배경색은 노란색입니다.
            headStyle.setFillForegroundColor(HSSFColor.HSSFColorPredefined.YELLOW.getIndex());
            headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            // 데이터용 경계 스타일 테두리만 지정
            CellStyle bodyStyle = workbook.createCellStyle();
            bodyStyle.setBorderTop(BorderStyle.THIN);
            bodyStyle.setBorderBottom(BorderStyle.THIN);
            bodyStyle.setBorderLeft(BorderStyle.THIN);
            bodyStyle.setBorderRight(BorderStyle.THIN);
            // 헤더명 설정
            String[] headerArray = {"아이디", "회원등급", "이름", "생일", "성별", "전화번호","이메일","주소","인증상태","가입일"};
            row = sheet.createRow(rowNo++);
            for (int i = 0; i < headerArray.length; i++) {
                cell = row.createCell(i);
                cell.setCellStyle(headStyle);
                cell.setCellValue(headerArray[i]);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Users getLoginUser() throws Exception {
        return (Users)session.getAttribute("loginUser");
    }
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
