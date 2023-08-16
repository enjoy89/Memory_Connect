package com.memory.connect.model.test.entity;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.base.BaseTimeEntity;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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

//    @OneToMany(mappedBy = "test", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
//    private List<Answer> answers = new ArrayList<>();

    @Builder
    public Test(String question) {
        this.question = question;
    }
}
