package com.weaverloft.ganttchart.Service;


import com.weaverloft.ganttchart.dto.Member;

import java.util.List;
import java.util.Map;

public interface MemberService {
    //2. 아이디로 회원 1명 조회
    Member findMemberById(String mId) throws Exception;
    //3. 비밀번호 체크
    Map<String, Object> isValidPassword(String mPassword) throws Exception;
    //4. 회원가입
    int createMember(Member member) throws Exception;
    //5. 로그인
    Member login(String id, String password) throws Exception;
    //6. 사용자 상태번호 변경
    int updateMemberStatus(String mId,int mStatusNo) throws Exception;
    //7. 이름, 이메일로 아이디리스트 일부 찾기
    List<String> findIdByNameEmail(String name, String email) throws Exception;
    //8. 아이디, 이름, 이메일로 임시비번 설정하기
    int findByIdNameEmail(String id, String name, String email) throws Exception;
    //9. 임시비번으로 변경하기
    int updatePassword(String id, String mPassword) throws Exception;
}
