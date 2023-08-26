package com.memory.connect.controller;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.answer.repository.AnswerRepository;
import com.memory.connect.model.member.entity.Member;
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
import java.util.List;
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

    //chat-gpt 와 간단한 채팅 서비스 소스

    /**
     * 사용자로부터 응답 데이터를 가져와서 DB에 저장
     * Front에서 답변을 하는 순간 GPT가 답변을 판단하여 Answer Table에 조장해주는 동작을함
     */
    @PostMapping("/get-answer")
    public ResponseEntity<Answer> getAnswerFromMember(@RequestBody RequestData requestData) {
        //여기로 test_id가 들어오게됨
        String receivedText = requestData.getVoiceText();
        int receivedTestId = requestData.getTestId();
        String receivedMemberName = requestData.getMemberName();
        /**
         * 만약 testId가 1이라면 어떤 이름이 뭔지 사용자 설정으로 넣어줌
         * receivedMemberName를 가져와서 모든 멤버리스트를 가져와서 일치하는 멤버 번호 리턴
         * */



        String ResultQuestion = speechToTextService.makeQuestion(receivedTestId, receivedText);
        return ResponseEntity.ok(questionService.saveAnswer(receivedTestId, requestData, ResultQuestion.contains("1")));
    }

}
