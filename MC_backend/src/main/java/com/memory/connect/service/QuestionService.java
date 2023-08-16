package com.memory.connect.service;


import com.memory.connect.model.test.entity.Test;
import com.memory.connect.model.test.repository.TestRepository;
import com.memory.connect.service.dto.MessageRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;

@Service
@RequiredArgsConstructor
public class QuestionService {

    private final TestRepository testRepository;

    public Test getQuestionById(Long id) {
        return testRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Question not found with id: " + id));
    }

    public Test getAnswerByQuestionId(Long questionId) {
        return testRepository.findById(questionId)
                .orElseThrow(() -> new EntityNotFoundException("Answer not found with questionId: " + questionId));
    }

    /*
    public Test saveAnswer(MessageRequestDto responseDto) {
        return null;
    }
     */

}
