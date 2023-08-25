package com.memory.connect.controller;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.answer.repository.AnswerRepository;
import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.test.entity.Test;
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
     * Chat GPT에게 질문을 보낸 후, 반환 받은 결과 (0 or 1) 값을 저장한다.
     * @param id
     * @return
     */
    @PostMapping("/{id}") // 여기서 id는 질문의 id ex) id == 1 => 이름은 무엇인가요?
    public ResponseEntity<String> sendMessageToGPT(@PathVariable int id) {
        String ResultQuestion = speechToTextService.makeQuestion(id);
        /**
         * 2023/08/21 Gpt에게 질문을 보낸후 0혹은 1로 이루어진 답변을 저장한다.
         * */

//        questionService.saveTestResult(id, ResultQuestion.contains("1"));
        //자 여기까지 됐어 그럼 이 ResultQuestion을 어디에 저장하느냐 인데
        return ResponseEntity.ok(ResultQuestion);
    }

//    @PostMapping("/{id}")
//    public ResponseEntity<Void> saveGptResult(@PathVariable int id) {
//        Test test  = testRepository.findById(id)
//                .orElseThrow(() -> new EntityNotFoundException("Test not found with id: " + id));
//
//        Answer answer = answerRepository.findAnswerByTest(test);
//
//
//    }

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

        return ResponseEntity.ok(questionService.saveAnswer(receivedTestId, requestData));
    }
}
