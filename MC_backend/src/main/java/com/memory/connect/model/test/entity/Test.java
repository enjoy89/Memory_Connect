package com.memory.connect.model.test.entity;

import com.memory.connect.model.base.BaseTimeEntity;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "test")
public class Test extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "test_id")
    private Long id;

    @Column(name = "test_question")
    private String question;

    @Column(name = "test_answer")
    private String answer;

    @Builder
    public Test(String question, String answer) {
        this.question = question;
        this.answer = answer;
    }
}
