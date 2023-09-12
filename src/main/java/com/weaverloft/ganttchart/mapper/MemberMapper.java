package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MemberMapper {
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
    int updateMemberStatus(Map<String, Object> map) throws Exception;
    //5-1. 이메일 인증완료(1)
    //5-2. PW 임시비번 상태
    //5-3. PW 변경
    //5-4. 휴면계정(98)
    //5-5. 회원탈퇴(99)
    //6. 회원 삭제
    int deleteMember(String mId) throws Exception;
    //7. 이름, 이메일로 아이디 일부 찾기
    List<String> findIdPart(Map<String, Object> map) throws Exception;
    //8. 이름, 이메일로 아이디 전체 찾기?
    String findId(Map<String, Object> map) throws Exception;
    //9. 아이디, 이름, 이메일로 임시비번 받기
    int updatePassword(Map<String, Object> map) throws Exception;
    //10. 회원 정보 수정
    int updateMemberDetail(Member member) throws Exception;
    //11. 비밀번호 일치확인
    int ismatchPassword(Map<String, Object> map) throws Exception;
    //12. 아이디,이름,이메일로 사람 찾기
    int findByIdNameEmail(Map<String, Object> map) throws Exception;
}
