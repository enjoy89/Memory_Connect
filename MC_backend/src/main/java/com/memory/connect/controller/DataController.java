package com.memory.connect.controller;

import com.memory.connect.model.test.entity.Test;
import com.memory.connect.service.QuestionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(value = "/api", produces = "application/json;charset=UTF-8")
@Slf4j
@RequiredArgsConstructor
public class DataController {

    private final QuestionService questionService;

    @GetMapping("/data")
    public List<Test> getAllData() {
        List<Test> testData = questionService.getAllData();
        log.info("-----------전송된 질문목록 확인용----------");
        for (Test test : testData) {
            log.info("Test ID: " + test.getId());
            log.info("Test Question: " + test.getQuestion());
        }
        return questionService.getAllData();
    }

    @GetMapping("/data/{id}")
    public Test getDataById(@PathVariable int id) {
        return questionService.getDataById(id);
    }
}