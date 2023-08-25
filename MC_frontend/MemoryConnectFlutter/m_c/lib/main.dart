import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:m_c/controller/question_controller.dart';
import 'package:m_c/screens/loading.dart';
import 'package:m_c/screens/loading_result.dart';
import 'package:m_c/screens/new_quiz_screen.dart';
import 'package:m_c/screens/pre_question_screen.dart';
import 'package:m_c/screens/quiz_screen.dart';
import 'package:m_c/data/questionData.dart';

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'AI Leo와',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                '인지 기능을',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '평가해 보세요!',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 70,
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
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                  ),
                ),
                child: const Text(
                  '시작',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
