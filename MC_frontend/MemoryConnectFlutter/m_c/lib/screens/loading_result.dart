import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:lottie/lottie.dart';
import 'package:m_c/screens/new_quiz_screen.dart';

class LoadingResult extends StatefulWidget {
  const LoadingResult({Key? key}) : super(key: key);

  @override
  State<LoadingResult> createState() => _LoadingResultState();
}

class _LoadingResultState extends State<LoadingResult>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final http.Client httpClient; // Declare the http.Client object

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500), // 애니메이션 실행 시간 설정
    );
    _controller.forward(); // 애니메이션 실행

    httpClient = http.Client();

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewQuizScreen(httpClient: httpClient)),
      );
    });
  }

  @override
  void dispose() {
    httpClient.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Animation Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/fb85b9bf-232c-42ac-af2f-a062f733da62/a45vzucNyR.json', // Lottie 애니메이션 파일 경로
              width: 300,
              height: 300,
            ),
            const Text(
              '잠시만 기다려 주세요...',
              style: TextStyle(fontSize: 40, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
