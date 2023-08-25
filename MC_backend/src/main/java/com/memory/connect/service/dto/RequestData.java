package com.memory.connect.service.dto;

import com.memory.connect.model.answer.entity.Answer;
import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RequestData {
    private int testId;
    private String voiceText;
    private String memberName;

    /**
     * Front에서 주는 형식대로 정의해줌
     * @param testId
     * @param voiceText
     * @param memberName
     */
    @Builder
    public RequestData(int testId, String voiceText, String memberName) {
        this.testId = testId;
        this.voiceText = voiceText;
        this.memberName = memberName;
    }

    public Answer toEntity(Test test, Member member, boolean gpt_result) {
        return Answer.builder()
                .content(this.voiceText)
                .test(test)
                .member(member)
                .gpt_result(gpt_result)
                .build();
    }
}