package com.memory.connect.service.dto;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RequestData {
    private int testId;
    private String voiceText;

//    public String getVoiceText() {
//        return voiceText;
//    }
//
//    public String getTestId() {
//        return testId;
//    }
//
//    public void setVoiceText(String voiceText) {
//        this.voiceText = voiceText;
//    }

    @Builder
    public RequestData(int testId, String voiceText) {
        this.testId = testId;
        this.voiceText = voiceText;
    }

    public Answer toEntity(Test test) {
        return Answer.builder()
                .content(this.voiceText)
                .test(test)
                .build();
    }
}