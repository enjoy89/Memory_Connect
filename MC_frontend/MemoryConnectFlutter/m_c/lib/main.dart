import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:m_c/controller/question_controller.dart';
import 'package:m_c/screens/loading.dart';
import 'package:m_c/screens/loading_result.dart';
import 'package:m_c/screens/new_quiz_screen.dart';
import 'package:m_c/data/questionData.dart';
import 'package:lottie/lottie.dart';
import 'package:m_c/screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory connect',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final http.Client httpClient; // Declare the http.Client object
  QuestionController questionController = Get.put(
      QuestionController()); // Rather Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    httpClient = http.Client(); // Initialize the http.Client object
  }

  @override
  void dispose() {
    httpClient.close(); // Close the http.Client when no longer needed
    super.dispose();
  }

  //Back to Front / 질문을 받아와서 자막과 같이 보여주는 역할
  Future<void> fetchDataAndShowCaptions() async {
    final response =
        await http.get(Uri.parse('http://localhost:8088/api/data'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩 추가
      questionController.captions.clear();
      for (var data in jsonData) {
        final question = questionData.fromJson(data).testQuestion;
        questionController.captions.add(question); // 질문을 자막에 추가
      }
      print("Back to Front Complete!!!!");
      print("축하드립니다람쥐 춤을 추세요");
    } else {
      print("자막 생성 문제가 발생했습니다 Error Code:");
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFDF6),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // logo 이미지

            Image.network(
              "https://careerup-client.s3.ap-northeast-2.amazonaws.com/logo.png",
              width: 100,
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '안녕하세요,\nAI 치매 검사 도우미 입니다.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '대화를 하고 싶다면\n눌러주세요 :)',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4D4D4D)),
                ),
              ),
            ),
            Image.network(
              "https://careerup-client.s3.ap-northeast-2.amazonaws.com/big_logo.png",
              width: 250,
              height: 250,
            ),
            // lottie 화살표
            Lottie.network(
              'https://lottie.host/66772b2f-54f7-41e3-a4d3-96644ba85e16/GeCtE4fJdJ.json', // Lottie 애니메이션 파일 경로
              width: 300,
              height: 180,
            ),
            ElevatedButton(
              onPressed: () async {
                await fetchDataAndShowCaptions(); // 자막 데이터 불러와서 저장.
                print(questionController.captions.length);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => NewQuizScreen(
                    //     httpClient: httpClient), // Pass the http.Client
                    builder: (context) => const Loading(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: const BorderSide(color: Color(0xff75A569)), // 테두리 색상
                  ),
                ),
              ),
              child: const Text(
                '대화하기',
                style: TextStyle(
                    fontSize: 35,
                    color: Color(0xff75A569),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
