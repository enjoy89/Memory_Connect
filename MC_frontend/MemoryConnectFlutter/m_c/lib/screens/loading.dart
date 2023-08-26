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
      backgroundColor: const Color(0xff7DBC85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://careerup-client.s3.ap-northeast-2.amazonaws.com/loading_logo.png",
              width: 300,
              height: 300,
            ),
            Lottie.network(
              'https://lottie.host/2d863168-2268-4817-80a7-dc3536060b9f/j0TWLqogSf.json', // Lottie 애니메이션 파일 경로
              width: 100,
              height: 100,
            ),
            // Text(
            //   '잠시만 기다려 주세요...',
            //   style: TextStyle(
            //     fontSize: 40,
            //     color: Colors.deepPurple.shade900,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
