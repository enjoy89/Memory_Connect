package com.memory.connect.service;

import io.github.flashvayne.chatgpt.service.ChatgptService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SpeechToTextService {
    private final String BASE_PROMPT = "너는 지금부터 질문에 적절한 문맥으로 대답을 했는지 확인해주는 거야. 문제에 대한 대답이 문맥상 적절한지 판단해서 적절하지 않으면 0, 적절하면 1 을 반환해줘.";
    private final ChatgptService chatgptService;

    /**
     * Chat GPT에게 질문을 던진다.
     */
    public String getChatResponse(String question) {
        String requestMessage = BASE_PROMPT + question;
        return chatgptService.sendMessage(requestMessage);
    }
}
