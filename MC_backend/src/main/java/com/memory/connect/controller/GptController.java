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
public class GptController {
    private final SpeechToTextService speechToTextService;
    private final DataService questionService;
    private final ChatgptService chatgptService;

    /**
     * Chat GPT와 간단한 채팅 서비스
     */
    @PostMapping("/{id}")
    public ResponseEntity<String> sendMessageToGPT(@PathVariable int id) {
        return ResponseEntity.ok(speechToTextService.getChatResponse(speechToTextService.makeQuestion(id)));
    }

    /**
     * 사용자로부터 응답 데이터를 가져와서 DB에 저장
     */
    @PostMapping("/get-answer")
    public ResponseEntity<Answer> getAnswerFromMember(@RequestBody RequestData requestData) {

        String receivedText = requestData.getVoiceText();
        int receivedTestId = requestData.getTestId();
        System.out.println("Question Id: " + receivedTestId);
        System.out.println("Received Voice Text: " + receivedText);

        return ResponseEntity.ok(questionService.saveAnswer(receivedTestId, requestData));
    }



}
