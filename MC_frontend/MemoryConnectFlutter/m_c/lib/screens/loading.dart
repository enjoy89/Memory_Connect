import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:lottie/lottie.dart';
import 'package:m_c/screens/new_quiz_screen.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingResultState();
}

class _LoadingResultState extends State<Loading>
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/bb0142f7-f6c5-458d-b42b-bebae0e8cf94/jhXlKSR4dw.json', // Lottie 애니메이션 파일 경로
              width: 300,
              height: 300,
            ),
            Text(
              '잠시만 기다려 주세요...',
              style: TextStyle(
                fontSize: 40,
                color: Colors.deepPurple.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
