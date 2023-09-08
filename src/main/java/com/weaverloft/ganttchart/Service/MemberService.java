package com.weaverloft.ganttchart.Service;


import com.weaverloft.ganttchart.dto.Member;

import java.util.Map;

public interface MemberService {
    //2. 아이디로 회원 1명 조회
    Member findMemberById(String mId) throws Exception;
    //3. 비밀번호 체크
    Map<String, Object> isValidPassword(String mPassword) throws Exception;
    //4. 회원가입
    int createMember(Member member) throws Exception;
}
