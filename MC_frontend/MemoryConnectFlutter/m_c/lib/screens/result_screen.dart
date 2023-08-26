import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            Row(
              children: [
                Image.network(
                    "https://careerup-client.s3.ap-northeast-2.amazonaws.com/logo.png",
                    width: 100,
                    height: 100),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "결과 : ",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                FutureBuilder(
                  future: getResult(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // 데이터를 성공적으로 받아왔을 때 표시할 위젯
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    } else {
                      // 데이터를 아직 받아오지 못했을 때 표시할 위젯
                      return Text('데이터를 아직 받아오지 못했습니다.');
                    }
                  },
                ),
                Text(
                  "/8 ",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: 300,
              height: 300,
              child: Image.network(
                "https://careerup-client.s3.ap-northeast-2.amazonaws.com/result.png",
                width: 300,
                height: 300,
              ),
            ),
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

Future<String> getResult() async {
  final response =
      await http.get(Uri.parse('http://localhost:8088/api/result'));
  if (response.statusCode == 200) {
    print("아래는 정답의 갯수");
    print(response.body);
    print("결과를 받아왔습니다!");
    return response.body;
  } else {
    print("getResult에서 에러가 발생했습니다");
    throw Exception('Failed to load data');
  }
}
