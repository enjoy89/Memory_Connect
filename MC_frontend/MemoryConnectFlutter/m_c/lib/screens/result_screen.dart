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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              width: 500,
              height: 350,
              child: Image.network(
                "https://careerup-client.s3.ap-northeast-2.amazonaws.com/result.png",
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              // decoration: BoxDecoration(
              //   color: const Color(0xfff4f4f4),
              //   borderRadius: const BorderRadius.vertical(
              //       top: Radius.circular(50)), //모서리를 둥글게
              //   border: Border.all(
              //     color: const Color(0xffFFFDF6),
              //     width: 3,
              //   ),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(height: 10),
                    const Text(
                      '인지적 정상',
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff7DBC85),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '인지 기능이 비교적 잘 유지되고 계십니다. \n따라서 현재 치매 가능성이 낮습니다.',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      maxLines: 5,
                      text: const TextSpan(
                        text:
                            '그러나 이후 기억력이나 기타 지적 능력(언어 표현 및 이해력, 판단력, 시공간 능력, 계산 능력 등)이 지금보다 좀 더 나빠지는 느낌이 있다면 미루지 마시고 다시 검사를 받아보록 하십시오.',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          //메인 색상
                          backgroundColor: const Color(0xffFFFFFF),
                          // 테두리
                          side: const BorderSide(
                            color: Color(0xff7DBC85),
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
                            color: Color(0xff7DBC85),
                          ),
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
