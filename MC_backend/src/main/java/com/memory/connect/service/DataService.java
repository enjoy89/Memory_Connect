package com.memory.connect.service;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.answer.repository.AnswerRepository;
import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.member.repository.MemberRepository;
import com.memory.connect.model.test.entity.Test;
import com.memory.connect.model.test.repository.TestRepository;
import com.memory.connect.service.dto.RequestData;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class DataService {
    private final MemberRepository memberRepository;
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

    public Answer saveAnswer(int id, RequestData requestData, boolean gpt_result) {
        Test test = testRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Test not found with id: " + id));

        Member member = memberRepository.findByName(requestData.getMemberName());


        return answerRepository.save(requestData.toEntity(test, member, gpt_result));
    }


    public List<Test> getAllData() {
        return testRepository.findAll();
    }
    public List<Answer> getAllAnswer() {
        return answerRepository.findAll();
    }
    public List<Member> getAllMember() {
        return memberRepository.findAll();
    }

    public Test getDataById(int id) {
        return testRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("test data not found with id: " + id));
    }
}
