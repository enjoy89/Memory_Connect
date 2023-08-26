import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
      backgroundColor: const Color(0xff7DBC85),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                '수고하셨습니다!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffFFFFFF),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffFFFDF6),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(30)), //모서리를 둥글게
                  // border: Border.all(
                  //   color: const Color(0xffFFFDF6),
                  //   width: 3,
                  // ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 500,
                    height: 300, // 높이를 원하는 크기로 지정
                    child: NormalDistributionGraph(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 550, //MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 2,
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '[찬호씨는]',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '기억력이 아주 좋습니다. 굳 굳 굳',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      // 결과 api로 받아오기
                      FutureBuilder(
                        future: getResult(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // 데이터를 성공적으로 받아왔을 때 표시할 위젯
                            return Text(snapshot.data.toString());
                          } else {
                            // 데이터를 아직 받아오지 못했을 때 표시할 위젯
                            return Text('데이터를 아직 받아오지 못했습니다.');
                          }
                        },
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
      ),
    );
  }
}

class NormalDistributionGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: -4,
        maxX: 4,
        minY: 0,
        maxY: 0.5,
        lineBarsData: [
          LineChartBarData(
            spots: generateSpots(),
            isCurved: true,
            colors: [Color(0xff7DBC85)],
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        extraLinesData: ExtraLinesData(
          verticalLines: [
            VerticalLine(
                x: 0.2, color: Colors.red, strokeWidth: 3, dashArray: [10, 5])
          ],
        ),
      ),
    );
  }

  List<FlSpot> generateSpots() {
    List<FlSpot> spots = [];
    for (double x = -4; x <= 4; x += 0.1) {
      double y = (1 / (sqrt(2 * pi))) * exp(-(pow(x, 2)) / 2);
      spots.add(FlSpot(x, y));
    }
    return spots;
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
