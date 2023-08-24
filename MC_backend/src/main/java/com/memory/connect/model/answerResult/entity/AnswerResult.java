package com.memory.connect.model.answerResult.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@Table(name = "answerResult")
@NoArgsConstructor  // 기본 생성자 추가
public class AnswerResult {
    /**
     * 2023/08/23 나중에 조인해서 디벨럽
     * */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "answerResult_id")
    private int id;

    @Column(name = "test_id")
    private int test_id;

    @Column(name = "gpt_result")
    private boolean gpt_result;

//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "test_id")
//    @JsonIgnore
//    private Member member;

    @Builder
    public AnswerResult(int test_id , boolean gpt_result) {
        this.test_id = test_id;
        this.gpt_result = gpt_result;
    }

}
