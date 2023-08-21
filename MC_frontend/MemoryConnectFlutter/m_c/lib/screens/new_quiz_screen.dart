import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_c/controller/question_controller.dart';
import 'package:m_c/data/questionData.dart';
import 'package:m_c/screens/loading_result.dart';
import 'package:m_c/screens/result_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class NewQuizScreen extends StatefulWidget {
  final http.Client httpClient; // Change this to http.Client

  const NewQuizScreen({Key? key, required this.httpClient}) : super(key: key);

  @override
  State<NewQuizScreen> createState() => _NewQuizScreenState();
}

class _NewQuizScreenState extends State<NewQuizScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  int testId = 1;
  late Future<List<questionData>> futureData;
  final int _currentCaptionIndex = 0; // 현재 출력할 자막 인덱스
  final PageController _pageController = PageController();

  QuestionController questionController = Get.put(QuestionController());
  CarouselController carouselController = CarouselController();

  int activeIndex = 0;
  List<String> videos = [
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/성함을_말씀해주세요.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/지금_계신_이_장소는_어떤_곳인가요.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/지금_생각나는_물건_3가지를_아무거나_말씀해주세요.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/주민등록증을_주웠을때.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/성함을_말씀해주세요.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/성함을_말씀해주세요.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/성함을_말씀해주세요.mp4",
  ];

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _initSpeech();

    // 웹용 VideoPlayerController 생성
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(videos[activeIndex]));
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

  //----------------------
  Widget imageSlider(path, index) {
    _controller.dispose();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(videos[activeIndex]));
    _initializeVideoPlayerFuture = _controller.initialize();

    return SizedBox(
      width: double.infinity,
      height: 240,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            _controller.play(); // 바로 재생하도록.
            _controller.value.duration.inMilliseconds;
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
    );
  }

  Widget indicator() => Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: questionController.captions.length,
        onDotClicked: (index) {
          carouselController.jumpToPage(index);
        },
        effect: ScaleEffect(
            dotHeight: 25,
            dotWidth: 25,
            spacing: 35,
            activeDotColor: Colors.deepPurple.shade400,
            dotColor: Colors.deepPurple.shade100.withOpacity(0.8)),
      ));

  //-----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  indicator(),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CarouselSlider.builder(
                        // Set carousel controller
                        carouselController: carouselController,
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.5,
                          initialPage: 0,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) => setState(() {
                            activeIndex = index;
                          }),
                        ),
                        itemCount: videos.length,
                        itemBuilder: (context, index, realIndex) {
                          final path = videos[index];
                          return imageSlider(path, index);
                        },
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width * 0.6,
                        bottom: 10,
                        child: Container(
                          color: Colors.black,
                          child: RichText(
                            maxLines: 5,
                            text: TextSpan(
                              text: activeIndex >= 0 ||
                                      activeIndex <
                                          questionController.captions.length
                                  ? questionController.captions[activeIndex]
                                  : '자막이 생성되는 구역입니다.',
                              style: const TextStyle(
                                backgroundColor: Colors.black,
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                            textAlign: TextAlign.center, // 자막 중앙 정렬
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          print('말하기');
                          _speechToText.isNotListening
                              ? setState(() {
                                  _startListening();
                                  print(_lastWords);
                                })
                              : setState(() {
                                  _stopListening();
                                  _sendVoiceDataToApi(_lastWords);
                                });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 30),
                          ),
                        ),
                        child: Text(
                          _speechToText.isNotListening ? '말하기' : 'STOP',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Next');
                          if (activeIndex >=
                              questionController.captions.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // Pass the http.Client
                                builder: (context) => const LoadingResult(),
                              ),
                            );
                          }
                          carouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple.shade100),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 30),
                          ),
                        ),
                        child: Text(
                          activeIndex >= questionController.captions.length - 1
                              ? '완료'
                              : '다음 >',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
