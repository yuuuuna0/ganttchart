package com.weaverloft.ganttchart.dao;


import com.weaverloft.ganttchart.dto.Member;

import java.util.List;

public interface MemberDao {
    //1. 회원생성
    int createMember(Member member) throws Exception;
    //2. 아이디로 회원 1명 조회
    Member findMemberById(String mId) throws Exception;
    //3-1. 회원 전체 조회
    List<Member> findAllMember() throws Exception;
    //3-2. 회원 전체 조회(페이징)

    //4. 전체회원 수 조회
    int findAllMemberCount() throws Exception;
    //5. 회원 상태 변경
    /*
이메일 인증완료(1) / PW 임시비번 상태 / PW 변경 /휴면계정(98) /회원탈퇴(99)
     */
    int updateMemberStatus(String mId, int mStatusNo) throws Exception;

    //6. 회원 삭제
    int deleteMember(String mId) throws Exception;
    //7. 이름, 이메일로 아이디 일부 찾기
    List<String> findIdPart(String mName, String mEmail) throws Exception;
    //8. 이름, 이메일로 아이디 전체 찾기?
    String findId(String mName, String mEmail) throws Exception;
    //9. 아이디, 이름, 이메일로 임시비번 받기
    int findByIdNameEmail(String mId, String mName, String mEmail) throws Exception;
    //10. 회원 정보 수정
    int updateMemberDetail(Member member) throws Exception;
    //11. 비밀번호 일치확인
    int ismatchPassword(String mId, String mPassword) throws Exception;
    //12. 비밀번호 변경
    int updatePassword(String id, String encryptTempPassword) throws Exception;
}
