package com.memory.connect.model.answer.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.memory.connect.model.base.BaseTimeEntity;
import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.test.entity.Test;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "answer")
public class Answer extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "answer_id")
    private int id;

    /**
     * 답변 내용
     */
    @Column(name = "answer_content",columnDefinition = "VARCHAR(255) CHARACTER SET UTF8")
    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    @JsonIgnore
    private Test test;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    @JsonIgnore
    private Member member;

    @Column(name = "gpt_result")
    private boolean gpt_result;

    @Builder
    public Answer(String content, Test test, Member member, boolean gpt_result) {
        this.content = content;
        this.test = test;
        this.member = member;
        this.gpt_result = gpt_result;
    }
}
