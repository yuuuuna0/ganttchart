package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.MemberDao;
import com.weaverloft.ganttchart.dto.Member;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class MemberServiceImpl implements MemberService{
    private MemberDao memberDao;

    public MemberServiceImpl(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

    @Override
    public Member findMemberById(String mId) throws Exception {
        return memberDao.findMemberById(mId);
    }

    @Override
    public Map<String, Object> isValidPassword(String mPassword) throws Exception {
        /*
          1) 6~15글자
          2) 영어, 숫자, 특수문자 포함
          3) 공백 안됨
        */
        Map<String, Object> map = new HashMap<>();
        String msg = "";
        boolean result=true;
        Matcher matcher;
        if(!mPassword.matches("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{6,12}$")){
            msg = "비밀번호는 영문,숫자,특수문자를 포함하여 6글자 이상 12글자 이하여야합니다.";
            result = false;
        }
        if(Pattern.compile("\\s").matcher(mPassword).find()){
            msg = "비밀번호에는 공백이 포함될 수 없습니다.";
            result = false;
        }
        map.put("msg",msg);
        map.put("result",result);
        return map;
    }

    @Override
    public int createMember(Member member) throws Exception {
        return memberDao.createMember(member);
    }

    @Override
    public Member login(String id, String password) throws Exception {
        Member member = memberDao.findMemberById(id);
        if(member == null || !member.getMPassword().equals(password)){
            return null;
        }
        return member;
    }

    @Override
    public int updateMemberStatus(String mId,int mStatusNo) throws Exception {
        return memberDao.updateMemberStatus(mId,mStatusNo);
    }

    @Override
    public List<String> findIdByNameEmail(String name, String email) throws Exception{
        return memberDao.findIdPart(name,email);
    }

    @Override
    public int findByIdNameEmail(String id, String name, String email) throws Exception{
        return memberDao.findByIdNameEmail(id,name,email);
    }

    @Override
    public int updatePassword(String id, String mPassword) throws Exception{
        return memberDao.updatePassword(id,mPassword);
    }
}
