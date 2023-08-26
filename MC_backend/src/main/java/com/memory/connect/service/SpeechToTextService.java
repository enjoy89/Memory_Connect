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
import java.time.LocalDate;

@Service
@RequiredArgsConstructor
@Slf4j
public class SpeechToTextService {
    private final String BASE_PROMPT = "내가 제시한 질문에 대한 답변이 맞는 말인지 확인해줘. 답변이 옳다면 1을, 그렇지 않다면 0을 반환해줘. 1과 0이외에는 절대 다른대답은 필요없어\n";
    private final String BASE_Question = "질문: ";
    private final String BASE_Answer = "\n답변: ";
    private final String BEFORE_Answer = "이전 답변: ";
    private final ChatgptService chatgptService;
    private final TestRepository testRepository;
    private final AnswerRepository answerRepository;

    /**
     * Chat GPT에게 질문을 던진다.
     */
    public String getChatResponse(String question) {
        return chatgptService.sendMessage(question);
    }

    /**
     * DB에 존재하는 질문 데이터와 사용자 답변 데이터를 불러온 후, 이를 프롬포트와 적절하게 조합하여 반환한다.
     */
    public String makeQuestion(int testId , String receivedText) {
        Test test = testRepository.findById(testId)
                .orElseThrow(() -> new EntityNotFoundException("test not found"));

        String test_question = BASE_Question + test.getQuestion();
        String member_response = BASE_Answer + receivedText;
        if (testId == 2){
            LocalDate now = LocalDate.now();
            test_question = "질문:" + now + "의 요일은?";
        }
        String question = BASE_PROMPT + test_question + member_response;
        log.info(question);

        return getChatResponse(question);
    }
}
