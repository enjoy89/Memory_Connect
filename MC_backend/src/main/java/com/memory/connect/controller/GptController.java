package com.memory.connect.controller;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.answer.repository.AnswerRepository;
import com.memory.connect.model.test.repository.TestRepository;
import com.memory.connect.service.DataService;
import com.memory.connect.service.SpeechToTextService;
import com.memory.connect.service.dto.RequestData;
import io.github.flashvayne.chatgpt.service.ChatgptService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
import java.util.Optional;

@RequiredArgsConstructor
@RestController
@Slf4j
@RequestMapping("/api/v1/chat-gpt")
@CrossOrigin(origins = "*")
public class GptController {
    private final TestRepository testRepository;
    private final AnswerRepository answerRepository;
    private final SpeechToTextService speechToTextService;
    private final DataService questionService;
    private final ChatgptService chatgptService;


    /**
     * Chap GPT에게 질문을 보낸 후, 받은 결과를 DB에 저장한다.
     */
    @PostMapping("/{id}")
    public ResponseEntity<String> sendMessageToGPT(@PathVariable int id) {
        String ResultQuestion = speechToTextService.makeQuestion(id);
        return ResponseEntity.ok(ResultQuestion);
    }


    //chat-gpt 와 간단한 채팅 서비스 소스

    /**
     * 사용자로부터 응답 데이터를 가져와서 DB에 저장
     */
    @PostMapping("/get-answer")
    public ResponseEntity<Answer> getAnswerFromMember(@RequestBody RequestData requestData) {
        //여기로 test_id가 들어오게됨
        String receivedText = requestData.getVoiceText();
        int receivedTestId = requestData.getTestId();
        System.out.println("Question Id: " + receivedTestId);
        System.out.println("Received Voice Text: " + receivedText);

        // DB에 답변을 저장함
        String ResultQuestion = speechToTextService.makeQuestion(receivedTestId);
        return ResponseEntity.ok(questionService.saveAnswer(receivedTestId, requestData, ResultQuestion.contains("1")));
    }
}
