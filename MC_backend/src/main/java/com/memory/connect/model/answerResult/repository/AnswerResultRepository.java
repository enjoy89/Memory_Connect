package com.memory.connect.model.answerResult.repository;

import com.memory.connect.model.answerResult.entity.AnswerResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AnswerResultRepository extends JpaRepository<AnswerResult, Integer> {

}