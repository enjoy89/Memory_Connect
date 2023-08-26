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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/fb85b9bf-232c-42ac-af2f-a062f733da62/a45vzucNyR.json', // Lottie 애니메이션 파일 경로
              width: 300,
              height: 300,
            ),
            Text(
              '잠시만 기다려 주세요...',
              style: TextStyle(
                fontSize: 50,
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
