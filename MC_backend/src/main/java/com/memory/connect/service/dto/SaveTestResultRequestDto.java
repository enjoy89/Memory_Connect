package com.memory.connect.service.dto;

import com.memory.connect.model.member.entity.Member;
import com.memory.connect.model.test.entity.Test;
import com.memory.connect.model.testResult.entity.TestResult;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaveTestResultRequestDto {

    private boolean gpt_result;
    private int testId;
    private int memberId;

    @Builder
    public SaveTestResultRequestDto(boolean gpt_result, int testId, int memberId) {
        this.gpt_result = gpt_result;
        this.testId = testId;
        this.memberId = memberId;
    }

    public TestResult toEntity(boolean gpt_result, Test test, Member member) {
        return TestResult.builder()
                .gpt_result(gpt_result)
                .test(test)
                .member(member)
                .build();
    }
}
