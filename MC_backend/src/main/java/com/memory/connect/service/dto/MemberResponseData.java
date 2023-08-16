package com.memory.connect.service.dto;

import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberResponseData {

    private Long testId;
    private String answer;

    @Builder
    public MemberResponseData(Long testId, String answer) {
        this.testId = testId;
        this.answer = answer;
    }

    public Test toEntity(String question) {
        return Test.builder()
                .question(question)
                .answer(this.answer)
                .build();
    }

}
