package com.memory.connect.service.dto;


import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MessageRequestDto {
    private String question;
    private String answer;

    @Builder
    public MessageRequestDto(String question, String answer) {
        this.question = question;
        this.answer = answer;
    }

    public Test toEntity(String question, String answer) {
        return Test.builder()
                .question(question)
                .answer(answer)
                .build();
    }

}
