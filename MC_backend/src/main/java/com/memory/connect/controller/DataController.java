package com.memory.connect.controller;

import com.memory.connect.model.answerResult.entity.AnswerResult;
import com.memory.connect.model.test.entity.Test;
import com.memory.connect.service.DataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api", produces = "application/json;charset=UTF-8")
@Slf4j
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class DataController {
    //CORS 설정
    private final DataService questionService;

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
    /**
     * 0821/추가된 to front api
     *
     * */
    @GetMapping("/result")
    public int getResult(){
        List<AnswerResult> resultData = questionService.getResult();
        int resultTrue = 0; //정답의 갯수
        for (AnswerResult ar : resultData) {
            if (ar.isGpt_result() == true)
                resultTrue++;
        }
        return resultTrue;
    }

    @GetMapping("/data/{id}")
    public Test getDataById(@PathVariable int id) {
        return questionService.getDataById(id);
    }
}