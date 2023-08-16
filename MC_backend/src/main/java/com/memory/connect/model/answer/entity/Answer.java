package com.memory.connect.model.answer.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.memory.connect.model.base.BaseTimeEntity;
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

    @Column(name = "answer_contnet")
    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    @JsonIgnore
    private Test test;

    @Builder
    public Answer(String content, Test test) {
        this.content = content;
        this.test = test;
    }
}
