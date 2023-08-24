package com.memory.connect.controller;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.service.DataService;
import com.memory.connect.service.SpeechToTextService;
import com.memory.connect.service.dto.RequestData;
import io.github.flashvayne.chatgpt.service.ChatgptService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@Slf4j
@RequestMapping("/api/v1/chat-gpt")
@CrossOrigin(origins = "*")
public class GptController {
    private final SpeechToTextService speechToTextService;
    private final DataService questionService;
    private final ChatgptService chatgptService;

    /**
     * Chat GPT와 간단한 채팅 서비스 프론트에서 호출하게됨
     */
    @PostMapping("/{id}") // 여기서 id는 질문의 id ex) id == 1 => 이름은 무엇인가요?
    public ResponseEntity<String> sendMessageToGPT(@PathVariable int id) {
        boolean ResultQuestion =speechToTextService.makeQuestion(id).toString().contains("1");
        /**
         * 2023/08/21 Gpt에게 질문을 보낸후 0혹은 1로 이루어진 답변을 저장한다.
         * */
        questionService.saveAnswerResult(id,ResultQuestion);
        //자 여기까지 됐어 그럼 이 ResultQuestion을 어디에 저장하느냐 인데
        return ResponseEntity.ok(speechToTextService.makeQuestion(id));
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

        return ResponseEntity.ok(questionService.saveAnswer(receivedTestId, requestData));
    }
}
