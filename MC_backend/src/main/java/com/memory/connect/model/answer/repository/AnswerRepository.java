package com.memory.connect.model.answer.repository;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.test.entity.Test;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AnswerRepository extends JpaRepository<Answer, Integer> {

    Answer findByTest(Test test);
}
