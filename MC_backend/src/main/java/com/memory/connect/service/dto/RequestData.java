package com.memory.connect.service.dto;

public class RequestData {
    private String testId;
    private String voiceText;
    public String getVoiceText() {
        return voiceText;
    }
    public String getTestId(){
        return testId;
    }
    public void setVoiceText(String voiceText) {
        this.voiceText = voiceText;
    }
}