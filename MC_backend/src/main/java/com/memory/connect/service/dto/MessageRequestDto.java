package com.memory.connect.service.dto;

import com.memory.connect.model.test.entity.Test;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MessageRequestDto {
    private String question;

    @Builder
    public MessageRequestDto(String question) {
        this.question = question;
    }

    public Test toEntity(String question) {
        return Test.builder()
                .question(question)
                .build();
    }

}
