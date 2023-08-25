import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m_c/screens/result_screen.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _TestState();
}

class _TestState extends State<Completed> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animationCompleted = false; // 애니메이션 완료 여부를 나타내는 변수

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // 애니메이션 실행 시간 설정
    );
    _controller.forward(); // 애니메이션 실행
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Lottie.network(
                'https://lottie.host/0e0dcdb6-764d-4152-9c67-cd713b147b41/dKqbBwf4gC.json', // Lottie 애니메이션 파일 경로
                width: 300,
                height: 300,
                controller: _controller, // AnimationController 연결
                onLoaded: (composition) {
                  _controller.addStatusListener((status) {
                    if (status == AnimationStatus.completed) {
                      setState(() {
                        _animationCompleted = true; // 애니메이션 완료 시 상태 업데이트
                        _controller.stop();
                      });
                    }
                  });
                },
              ),
              Text(
                '완료되었습니다.',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultScreen()),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                  ),
                ),
                child: const Text(
                  '결과 보기',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ButtonStyle(
              //     padding: MaterialStateProperty.all<EdgeInsets>(
              //       const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              //     ),
              //   ),
              //   child: const Text(
              //     '결과 전송하기',
              //     style: TextStyle(
              //       fontSize: 35,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
