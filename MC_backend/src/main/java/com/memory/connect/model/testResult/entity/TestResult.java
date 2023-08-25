package com.memory.connect.model.testResult.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

/**
 * 테스트 최종 결과
 * 의사 제출용 or 사용자 결과 확인 화면용
 */
@Entity
@Getter
@Table(name = "testResult")
@NoArgsConstructor  // 기본 생성자 추가
public class TestResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "testResult_id")
    private int id;

    /**
     * GPT 답변 결과
     * 1: 옳은 답변, 0: 옳지 않은 답변
     */
    @Column(name = "gpt_result")
    private boolean gpt_result;

    /**
     * TestResult : Test (N : 1)
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    @JsonIgnore
    private Test test;

    /**
     * TestResult : Member (N : 1)
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    @JsonIgnore
    private Member member;

    @Builder
    public TestResult(Test test, boolean gpt_result, Member member) {
        this.test = test;
        this.gpt_result = gpt_result;
        this.member = member;
    }
}
