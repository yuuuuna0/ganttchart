package com.weaverloft.ganttchart.util;

import com.weaverloft.ganttchart.Service.UsersService;
import com.weaverloft.ganttchart.dto.Users;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.List;

@Service
public class ExcelService {
    private UsersService usersService;

    public ExcelService(UsersService usersService) {
        this.usersService = usersService;
    }
    public void excelDown(HttpServletResponse response, String fileName) throws Exception{
        List<Users> userList = usersService.findUserList();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        //excel 다운 시작
        Workbook workbook = new HSSFWorkbook();
        //시트 생성
        Sheet sheet = workbook.createSheet(fileName);
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
        String[] headerArray = {"아이디","이름","이메일","성별","생일","전화번호","주소","회원상태","가입일"};
        row = sheet.createRow(rowNo++);
        for(int i=0; i<headerArray.length; i++){
            cell = row.createCell(i);
            cell.setCellStyle(headStyle);
            cell.setCellValue(headerArray[i]);
        }

        //데이터 입력
        for(Users users : userList){
            row = sheet.createRow(rowNo++);

            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getUId());

            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getUName());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getUEmail());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getUGender());

            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            if(users.getUBirth() != null) {
                cell.setCellValue(format.format(users.getUBirth()));
            }


            cell = row.createCell(5);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getUPhone());

            cell = row.createCell(7);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(users.getUAddress()+" "+users.getUAddress2());

            cell = row.createCell(8);
            cell.setCellStyle(bodyStyle);
            String status ="";
            switch (users.getUStatusNo()){
                case 1:
                    status="가입완료";
                    break;
                case 2:
                    status="인증완료";
                    break;
                case 3:
                    status="임시비밀번호";
                    break;
                case 98:
                    status="휴면계정";
                    break;
                case 99:
                    status="회원탈퇴";
                    break;
            }
            cell.setCellValue(status);

            cell = row.createCell(9);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(format.format(users.getUCreateDate()));
        }

        //컨텐트 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition","attachment;filename="+java.net.URLEncoder.encode(fileName+".xls","UTF-8"));

        //엑셀 출력
        workbook.write(response.getOutputStream());
        workbook.close();

    }
}
