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
      //backgroundColor: const Color(0xff7DBC85),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              '메모리 커넥트 결과',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.network(
                'https://careerup-client.s3.ap-northeast-2.amazonaws.com/result.png',
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: const Color(0xfff4f4f4),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '찬호님은',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '언어 기능과 이해 및 판단 능력이 좋아요!',
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
