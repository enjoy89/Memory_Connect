package com.memory.connect.service;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.answer.repository.AnswerRepository;
import com.memory.connect.model.test.entity.Test;
import com.memory.connect.model.test.repository.TestRepository;
import io.github.flashvayne.chatgpt.service.ChatgptService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;

@Service
@RequiredArgsConstructor
@Slf4j
public class SpeechToTextService {
    private final String BASE_PROMPT = "너는 지금부터 질문에 적절한 문맥으로 답변을 했는지 확인해주는 거야. 문제에 대한 대답이 문맥상 적절한지 판단해서 적절하지 않으면 0, 적절하면 1 을 반환해줘.";
    private final String BASE_Question = "질문: ";
    private final String BASE_Answer = "답변: ";
    private final ChatgptService chatgptService;
    private final TestRepository testRepository;
    private final AnswerRepository answerRepository;

    /**
     * Chat GPT에게 질문을 던진다.
     */
    public String getChatResponse(String question) {
        String requestMessage = BASE_PROMPT + question;
        return chatgptService.sendMessage(requestMessage);
    }

    /**
     * DB에 존재하는 질문 데이터와 사용자 답변 데이터를 불러온 후, 이를 프롬포트와 적절하게 조합하여 반환한다.
     */
    public String makeQuestion(int testId) {
        Test test = testRepository.findById(testId)
                .orElseThrow(() -> new EntityNotFoundException("test not found"));

        Answer answer = answerRepository.findByTest(test);

        String test_question = BASE_Question + test.getQuestion();
        String member_response = BASE_Answer + answer.getContent();

        String question = BASE_PROMPT + test_question + member_response;
        log.info(question);

        return question;

    }
}
