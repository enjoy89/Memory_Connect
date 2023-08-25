import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m_c/screens/completed.dart';

class LoadingResult extends StatefulWidget {
  const LoadingResult({Key? key}) : super(key: key);

  @override
  State<LoadingResult> createState() => _LoadingResultState();
}

class _LoadingResultState extends State<LoadingResult>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500), // 애니메이션 실행 시간 설정
    );
    _controller.forward(); // 애니메이션 실행

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Completed()),
      );
    });
  }

  @override
  void dispose() {
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
          ],
        ),
      ),
    );
  }
}
