package com.memory.connect.model.test.entity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "test")
public class Test {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "test_id")
    private int id;

    @Column(name = "test_question", columnDefinition = "VARCHAR(255) CHARACTER SET UTF8")
    private String question;

    @Column(name ="test_type", columnDefinition = "VARCHAR(255) CHARACTER SET UTF8")
    private String type;

    @Builder
    public Test(String question, String type) {
        this.question = question;
        this.type = type;
    }
}
