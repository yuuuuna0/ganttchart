package com.weaverloft.ganttchart.dao;

import com.weaverloft.ganttchart.dto.Member;
import com.weaverloft.ganttchart.mapper.MemberMapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MemberDaoImpl implements MemberDao {
    private MemberMapper memberMapper;

    public MemberDaoImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public int createMember(Member member) throws Exception {
        return memberMapper.createMember(member);
    }

    @Override
    public Member findMemberById(String mId) throws Exception {
        return memberMapper.findMemberById(mId);
    }

    @Override
    public List<Member> findAllMember() throws Exception {
        return memberMapper.findAllMember();
    }

    @Override
    public int findAllMemberCount() throws Exception {
        return memberMapper.findAllMemberCount();
    }

    @Override
    public int updateMemberStatus(String mId, int mStatusNo) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("mId",mId);
        map.put("mStatusNo",mStatusNo);
        return memberMapper.updateMemberStatus(map);
    }

    @Override
    public int deleteMember(String mId) throws Exception {
        return memberMapper.deleteMember(mId);
    }

    @Override
    public List<String> findIdPart(String mName, String mEmail) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("mName",mName);
        map.put("mEmail",mEmail);
        return memberMapper.findIdPart(map);
    }

    @Override
    public String findId(String mName, String mEmail) throws Exception {
        Map<String, Object> map =new HashMap<>();
        map.put("mName",mName);
        map.put("mEmail",mEmail);
        return memberMapper.findId(map);
    }

    @Override
    public int findByIdNameEmail(String mId, String mName, String mEmail) throws Exception {
        Map<String, Object> map =new HashMap<>();
        map.put("mId",mId);
        map.put("mName",mName);
        map.put("mEmail",mEmail);
        return memberMapper.findByIdNameEmail(map);
    }

    @Override
    public int updateMemberDetail(Member member) throws Exception {
        return memberMapper.updateMemberDetail(member);
    }

    @Override
    public int ismatchPassword(String mId, String mPassword) throws Exception {
        Map<String, Object> map =new HashMap<>();
        map.put("mId",mId);
        map.put("mPassword",mPassword);
        return memberMapper.ismatchPassword(map);
    }

    @Override
    public int updatePassword(String mId, String mPassword) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("mid",mId);
        map.put("mPassword",mPassword);
        return memberMapper.updatePassword(map);
    }
}
