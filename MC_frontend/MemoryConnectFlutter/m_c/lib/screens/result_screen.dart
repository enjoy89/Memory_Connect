import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7DBC85),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(child: Icon(Icons.image, size: 200)),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: const Color(0xffFFFDF6),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50)), //모서리를 둥글게
                border: Border.all(
                  color: const Color(0xffFFFDF6),
                  width: 3,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const Text(
                      '당신은...',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        //메인 색상
                        backgroundColor: const Color(0xffFFFFFF),
                        // 테두리
                        side: const BorderSide(
                          color: Color(0xffFC5B5B),
                          width: 2,
                        ),
                        // 안쪽 패딩(여백)
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                        // style: ButtonStyle(
                        //   padding: MaterialStateProperty.all<EdgeInsets>(
                        //     const EdgeInsets.symmetric(
                        //         horizontal: 50, vertical: 30),
                      ),
                      child: const Text(
                        '상담 받아보기',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFC5B5B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
