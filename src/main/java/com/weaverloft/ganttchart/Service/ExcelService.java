package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dao.UsersLogDao;
import com.weaverloft.ganttchart.dto.Users;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class ExcelService {

    private UsersDao usersDao;
    private UsersLogDao usersLogDao;

    public ExcelService(UsersDao usersDao,UsersLogDao usersLogDao) {
        this.usersDao = usersDao;
        this.usersLogDao = usersLogDao;
    }

    public void excelDown(HttpServletResponse response) throws Exception {

        List<Users> userList = usersDao.findUserList();

        //excel 다운 시작
        Workbook workbook = new HSSFWorkbook();
        //시트 생성
        Sheet sheet = workbook.createSheet("회원리스트");
        //행,열,열번호
        Row row = null;
        Cell cell = null;
        int rowNo = 0;

        //테이블 헤더용 스타일
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

        //헤더명 설정
        String[] headerArray = {"아이디","회원등급","이름","생일","성별","전화번호","이메일","주소","인증상태","가입일"};
        row = sheet.createRow(rowNo++);
        for(int i=0; i<headerArray.length; i++){
            cell = row.createCell(i);
            cell.setCellStyle(headStyle);
            cell.setCellValue(headerArray[i]);
        }

        //데이터 입력
        String grade = null;
        String gender = null;
        String authStatus = null;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = null;
        for(Users users : userList){
            row = sheet.createRow(rowNo++);

            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getId());

            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            if(users.getGrade() == 0) grade = "관리자";
            if(users.getGrade() == 1) grade = "일반회원";
            cell.setCellValue(grade);

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getName());

            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            date = format.format(users.getBirth());
            cell.setCellValue(date);

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            if(users.getGender() == 1) gender = "남자";
            if(users.getGender() == 2) gender = "여자";
            cell.setCellValue(gender);

            cell = row.createCell(5);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getPhone());

            cell = row.createCell(6);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getEmail());

            cell = row.createCell(7);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getAddress());

            cell = row.createCell(8);
            cell.setCellStyle(bodyStyle);
            if(users.getAuthStatus() == 0) authStatus = "X";
            if(users.getAuthStatus() == 1) authStatus = "O";
            cell.setCellValue(authStatus);

            cell = row.createCell(9);
            cell.setCellStyle(bodyStyle);
            date = format.format(users.getCreateDate());
            cell.setCellValue(date);
        }

        //컨텐트 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition","attachment;filename="+java.net.URLEncoder.encode("회원리스트.xls","UTF-8"));

        //엑셀 출력
        workbook.write(response.getOutputStream());
        workbook.close();


    }
}

