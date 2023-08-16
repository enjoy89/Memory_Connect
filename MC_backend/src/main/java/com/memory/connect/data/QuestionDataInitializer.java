package com.memory.connect.data;

import com.memory.connect.model.test.entity.Test;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
@RequiredArgsConstructor
public class QuestionDataInitializer {

    @PostConstruct
    public void init() {
        Test test_1 = Test.builder()
                .question("성함을 말씀해주세요.")
                .build();

        Test test_2 = Test.builder()
                .question("지금 계신 이 장소는 어떤 곳인가요?")
                .build();

        Test test_3 = Test.builder()
                .question("지금 생각 나는 물건 3가지를 아무거나 말씀해주세요.")
                .build();

        Test test_4 = Test.builder()
                .question("길에서 남의 주민등록증을 주웠다고 했을 때, 어떻게 하면 주인에게 찾아줄 수 있을까요?")
                .build();

        Test test_5 = Test.builder()
                .question("좀 전에 말씀하셨던 물건 3가지를 다시 말씀해주세요.")
                .build();

        Test test_6 = Test.builder()
                .question("아래 물건의 이름은 무엇일까요?")
                .build();

    }
}
