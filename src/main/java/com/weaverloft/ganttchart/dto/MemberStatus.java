package com.weaverloft.ganttchart.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberStatus {
    /*
    0: 가입 성공
    1: 이메일 인증 완료
    2: 임시비번으로 변경
    98: 휴면계정
    99: 회원탈퇴
     */
    private int mStatusNo;
    private String mStatus;
}
