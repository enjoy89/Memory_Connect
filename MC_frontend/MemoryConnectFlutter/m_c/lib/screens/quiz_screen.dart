import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m_c/data/questionData.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class QuizScreen extends StatefulWidget {
  final http.Client httpClient; // Change this to http.Client

  const QuizScreen({Key? key, required this.httpClient}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  int testId = 1;
  late Future<List<questionData>> futureData;
  final List<String> _captions = []; // 질문 데이터를 자막처럼 저장하는 리스트
  int _currentCaptionIndex = 0; // 현재 출력할 자막 인덱스

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _initSpeech();

    // 웹용 VideoPlayerController 생성
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        "https://careerup-client.s3.ap-northeast-2.amazonaws.com/KakaoTalk_Video_2023-08-15-14-52-52.mp4"));
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      print(_lastWords);
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  // 여기는 Front to Back 음성데이터를 testId와 voiceText JSON형식으로 전송함
  Future<void> _sendVoiceDataToApi(String voiceText) async {
    final response = await widget.httpClient.post(
      // Use the provided httpClient
      Uri.parse("http://localhost:8088/api/v1/chat-gpt/get-answer/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'testId': testId++, 'voiceText': voiceText}),
    );
    if (response.statusCode == 200) {
      print("Front to Back Complete!!!!");
      print("축하드립니다람쥐 춤을 추세요");
    } else {
      print("음성데이터 전송 문제가 발생했습니다 Error Code:");
      print(response.statusCode);
    }
  }

  //Back to Front / 질문을 받아와서 자막과 같이 보여주는 역할
  Future<void> fetchDataAndShowCaptions() async {
    final response =
        await http.get(Uri.parse('http://localhost:8088/api/data'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩 추가
      for (var data in jsonData) {
        final question = questionData.fromJson(data).testQuestion;
        _captions.add(question); // 질문을 자막에 추가
      }
      print("Back to Front Complete!!!!");
      print("축하드립니다람쥐 춤을 추세요");
    } else {
      print("자막 생성 문제가 발생했습니다 Error Code:");
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }

  //-----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '안녕하세요 Memory Connect 인공지능입니다.',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: Text(
                      _currentCaptionIndex < _captions.length
                          ? _captions[_currentCaptionIndex]
                          : '자막이 생성되는 구역입니다.',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center, // 자막 중앙 정렬
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (!snapshot.hasError) {
                          _controller.play(); // 바로 재생하도록.
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          print(snapshot.error);
                          return const CircularProgressIndicator(); // 로딩 중 표시
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Text(
                '답변: ${_speechToText.isListening ? _lastWords : _speechEnabled ? '우측 하단의 마이크를 눌러주세요.' : 'Speech not available'}',
                style: const TextStyle(
                  fontSize: 40,
                ), // 자막 중앙 정렬
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isNotListening
            ? () {
                _startListening();
                if (_currentCaptionIndex == 0) {
                  fetchDataAndShowCaptions();
                }
              }
            : () {
                _stopListening();
                _sendVoiceDataToApi(_lastWords);
                if (_currentCaptionIndex < _captions.length) {
                  setState(() {
                    _currentCaptionIndex++; // 다음 질문으로 이동
                  });
                }
              },
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
