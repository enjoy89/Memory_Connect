package com.memory.connect.controller;

import com.memory.connect.model.test.entity.Test;
import com.memory.connect.service.QuestionService;
import com.memory.connect.service.SpeechToTextService;
import com.memory.connect.service.dto.MemberResponseData;
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
    private final QuestionService questionService;
    private final ChatgptService chatgptService;

    /**
     * Chat GPT와 간단한 채팅 서비스g
     */
    @PostMapping("/{id}")
    public ResponseEntity<String> sendMessageToGPT(@PathVariable Long id) {
        Test question = questionService.getQuestionById(id);
        return ResponseEntity.ok(speechToTextService.getChatResponse(question.getQuestion()));
    }

    /**
     * 사용자로부터 응답 데이터를 가져와서 DB에 저장
     */
    @PostMapping("/{id}/get-answer")
    public ResponseEntity<Test> getAnswerFromMember(@PathVariable Long id, @RequestBody MemberResponseData data) {
        return ResponseEntity.ok(questionService.saveAnswer(id, data));
    }
}
