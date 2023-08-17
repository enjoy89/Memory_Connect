package com.memory.connect.controller;

import com.memory.connect.model.test.entity.Test;
import com.memory.connect.service.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(value = "/api", produces = "application/json;charset=UTF-8")
@RequiredArgsConstructor
public class DataController {

    private final QuestionService questionService;

    @GetMapping("/data")
    public List<Test> getAllData() {
        List<Test> testData = questionService.getAllData();
        System.out.println("-----------전송된 질문목록 확인용----------");
        for (Test test : testData) {
            System.out.println("Test ID: " + test.getId());
            System.out.println("Test Question: " + test.getQuestion());
            // 다른 필드들도 출력해보세요.
            System.out.println("-----------------------------");
        }
        return questionService.getAllData();
    }
}