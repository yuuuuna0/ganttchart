package com.weaverloft.ganttchart.mapper;

import com.weaverloft.ganttchart.dto.MemberType;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberTypeMapper {
    //1. 회원 등급 생성
    int createMemberType(MemberType memberType) throws Exception;
    //2. 회원 등급 삭제
    int deleteMemberType(int mTypeNo) throws Exception;
    //3. 회원 등급 조회
    MemberType findMemberTypeByNo(int mTypeNo) throws Exception;
    //4. 회원 등급 수정
    int updateMemberType(MemberType memberType) throws Exception;
}
