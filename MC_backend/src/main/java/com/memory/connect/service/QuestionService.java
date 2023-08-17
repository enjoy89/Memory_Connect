package com.memory.connect.service;


import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.answer.repository.AnswerRepository;
import com.memory.connect.model.test.entity.Test;
import com.memory.connect.model.test.repository.TestRepository;
import com.memory.connect.service.dto.RequestData;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;

@Service
@RequiredArgsConstructor
public class QuestionService {

    private final TestRepository testRepository;
    private final AnswerRepository answerRepository;

    public Test getQuestionById(int id) {
        return testRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Question not found with id: " + id));
    }

    public Test getAnswerByQuestionId(int questionId) {
        return testRepository.findById(questionId)
                .orElseThrow(() -> new EntityNotFoundException("Answer not found with questionId: " + questionId));
    }

    public Answer saveAnswer(int id, RequestData requestData) {
        Test test = testRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Test not found with id: " + id));

        return answerRepository.save(requestData.toEntity(test));
    }

    public List<Test> getAllData() {
        return testRepository.findAll();
    }
}
