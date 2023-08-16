package com.memory.connect.controller;
import com.memory.connect.service.dto.ApiResponse;
import com.memory.connect.service.dto.RequestData;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class ApiController {

    @PostMapping("/test")
    public ApiResponse testEndpoint(@RequestBody RequestData requestData) {
        // 여기서 requestData를 활용하여 원하는 작업 수행
        String receivedText = requestData.getVoiceText();
        int receivedTestId = requestData.getTestId();

        System.out.println("Question Id: " + receivedTestId);
        System.out.println("Received Voice Text: " + receivedText);

        ApiResponse response = new ApiResponse("Success", receivedText);
        return response;
    }
}