import 'dart:convert';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_c/controller/question_controller.dart';
import 'package:m_c/data/questionData.dart';
import 'package:m_c/screens/custom_keyboard_screen.dart';
import 'package:m_c/screens/drawing_popup.dart';
import 'package:m_c/screens/loading_result.dart';
import 'package:m_c/screens/result_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:math';
import 'dart:ui';

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

  List<List<double>> lines = []; // 각 선마다의 x, y 좌표 리스트

  QuestionController questionController = Get.put(QuestionController());
  CarouselController carouselController = CarouselController();

  int green = 0xff52d67f;
  int gray = 0xfff4f4f4;
  int darkGray = 0xffc8c8c8;

  int activeIndex = 0;
  List<String> videos = [
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/1.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/2.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/3.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/4.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/5.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/6.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/7.mp4",
    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/8.mp4",
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
    //setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    // setState(() {
    //   print(_lastWords);
    // });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    //setState(() {
    _lastWords = result.recognizedWords;
    //});
  }

  // 여기는 Front to Back 음성데이터를 testId와 voiceText JSON형식으로 전송함
  Future<void> _sendVoiceDataToApi(int testId, String voiceText) async {
    final response = await widget.httpClient.post(
      // Use the provided httpClient
      Uri.parse("http://localhost:8088/api/v1/chat-gpt/get-answer/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'testId': testId, 'voiceText': voiceText}),
    );
    if (response.statusCode == 200) {
      print("음성데이터 전송! testId : $testId, voiceText : $voiceText");
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
      height: MediaQuery.of(context).size.height / 1.5,
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
        effect: SlideEffect(
          radius: 0,
          dotHeight: 15,
          dotWidth: (MediaQuery.of(context).size.width - 100) /
              questionController.captions.length,
          spacing: 0,
          activeDotColor: const Color(0xff7DBC85),
          dotColor: const Color(0xffE7E7E7),
        ),
      ));

  //-----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(gray),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "${activeIndex + 1} / ${questionController.captions.length}"),
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
                          height: MediaQuery.of(context).size.height / 1.5,
                          initialPage: 0,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) => setState(() {
                            activeIndex = index;
                          }),
                          enableInfiniteScroll: false,
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
                                fontSize: 25,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [

                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width / 3,
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           print('Next');
                  //           if (activeIndex >=
                  //               questionController.captions.length - 1) {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 // Pass the http.Client
                  //                 builder: (context) => const LoadingResult(),
                  //               ),
                  //             );
                  //           } else {
                  //             carouselController.nextPage(
                  //                 duration: const Duration(milliseconds: 300),
                  //                 curve: Curves.linear);
                  //           }
                  //         },
                  //         style: OutlinedButton.styleFrom(
                  //           backgroundColor: const Color(0xffFFFFFF),
                  //           side: const BorderSide(
                  //             color: Color(0xff75A569),
                  //             width: 2,
                  //           ),
                  //           // 안쪽 패딩(여백)
                  //           padding: const EdgeInsets.symmetric(
                  //               vertical: 20, horizontal: 20),
                  //           shape: RoundedRectangleBorder(
                  //             side: const BorderSide(color: Color(0xff75A569)),
                  //             borderRadius: BorderRadius.circular(50),
                  //           ),
                  //         ),
                  //         child: Text(
                  //           activeIndex >=
                  //                   questionController.captions.length - 1
                  //               ? '완료'
                  //               : '다음 문제 >',
                  //           style: const TextStyle(
                  //             fontSize: 26,
                  //             fontWeight: FontWeight.bold,
                  //             color: Color(0xff75A569),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Obx(() {
                  if (questionController.isListening.value) {
                    return RippleAnimation(
                      repeat: true,
                      color: const Color(0xff7DBC85),
                      minRadius: 90,
                      ripplesCount: 6,
                      size: Size(MediaQuery.of(context).size.width - 150, 110),
                      child: Container(),
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  height: 110,
                  child: OutlinedButton(
                    onPressed: () {
                      if (activeIndex == 6) {
                        if (questionController.drawingAnswer.value) {
                          carouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const DrawingPopup(),
                          );
                        }

                        _sendVoiceDataToApi(activeIndex + 1, "오각형");
                      } else if (activeIndex == 4) {
                        if (questionController.tempAnswer.value != "") {
                          carouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const CustomKeyboardScreen(),
                          );
                        }
                      } else {
                        print('말하기');
                        if (_speechToText.isNotListening) {
                          questionController.isListening.value = true;
                          _startListening();
                          print(_lastWords);
                          if (activeIndex == 5) {
                            _sendVoiceDataToApi(
                                5, questionController.tempAnswer.value);
                          }
                        } else {
                          questionController.isListening.value = false;
                          _stopListening();
                          _sendVoiceDataToApi(activeIndex + 1, _lastWords);
                          print("${activeIndex + 1} : $_lastWords");
                          if (activeIndex >=
                              questionController.captions.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // Pass the http.Client
                                  builder: (context) => const LoadingResult()),
                            );
                          }
                          carouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      //메인 색상
                      backgroundColor: const Color(0xff7DBC85),
                      // 테두리
                      side: const BorderSide(
                        color: Color(0xff7DBC85),
                        width: 2,
                      ),
                      // 안쪽 패딩(여백)
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Obx(
                      () {
                        if (activeIndex == 6) {
                          if (questionController.drawingAnswer.value) {
                            return btnText('다음 >');
                          }
                          return btnText('그리기');
                        } else if (activeIndex == 4) {
                          if (questionController.tempAnswer.value != "") {
                            return btnText('다음 >');
                          }
                          return btnText('입력하기');
                        } else if (activeIndex >=
                            questionController.captions.length - 1) {
                          if (questionController.isListening.value) {
                            return btnText('완료');
                          } else {
                            return btnText('말하기');
                          }
                        } else if (questionController.isListening.value) {
                          return btnText('다음 >');
                        } else {
                          return btnText(!questionController.isListening.value
                              ? '말하기'
                              : '다음  >');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget btnText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    );
  }
}
