import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const DrawingPopup());
}

class DrawingPopup extends StatefulWidget {
  const DrawingPopup({super.key});

  @override
  _DrawingPopupState createState() => _DrawingPopupState();
}

class _DrawingPopupState extends State<DrawingPopup> {
  List<List<double>> lines = []; // 각 선마다의 x, y 좌표 리스트

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '그림 그리기 팝업',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: 300,
        height: 400,
        child: GestureDetector(
          onPanDown: (_) {
            lines.add([]); // 새로운 선 시작
          },
          onPanUpdate: (details) {
            setState(() {
              final position = details.localPosition;
              lines.last.add(position.dx);
              lines.last.add(position.dy);
            });
          },
          onPanEnd: (_) {
            // 마우스를 떼는 것을 선의 끝으로 처리
            lines.last.add(-1); // 특별한 값으로 선 끝을 나타냄
            _detectHexagon(lines); // 육각형인지 판별
          },
          child: CustomPaint(
            painter: MyPainter(lines),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              lines.clear();
            });
            Navigator.of(context).pop();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }

  void _detectHexagon(List<List<double>> lines) {
    final numSides = lines.length;
    print(numSides);
    if (numSides == 6) {
      final sideLengths = _calculateSideLengths(lines);
      final isHexagon = _isApproximatelyEqual(sideLengths[0], sideLengths[1]) &&
          _isApproximatelyEqual(sideLengths[1], sideLengths[2]) &&
          _isApproximatelyEqual(sideLengths[2], sideLengths[3]) &&
          _isApproximatelyEqual(sideLengths[3], sideLengths[4]) &&
          _isApproximatelyEqual(sideLengths[4], sideLengths[5]);

      if (isHexagon) {
        print('Detected hexagon');
      } else {
        print('Not hexagon');
      }
    }
  }

  List<double> _calculateSideLengths(List<List<double>> lines) {
    final sideLengths = <double>[];
    for (final line in lines) {
      final dx = line[2] - line[0];
      final dy = line[3] - line[1];
      final sideLength = _calculateDistance(dx, dy);
      sideLengths.add(sideLength);
    }
    return sideLengths;
  }

  double _calculateDistance(double dx, double dy) {
    return sqrt(dx * dx + dy * dy);
  }

  bool _isApproximatelyEqual(double a, double b, {double epsilon = 1.0}) {
    return (a - b).abs() < epsilon;
  }
}

class MyPainter extends CustomPainter {
  final List<List<double>> lines;

  MyPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (final line in lines) {
      for (int i = 0; i < line.length - 2; i += 2) {
        if (i + 3 < line.length) {
          final x1 = line[i];
          final y1 = line[i + 1];
          final x2 = line[i + 2];
          final y2 = line[i + 3];

          if (x1 != -1 && x2 != -1) {
            canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
          } else if (x1 != -1 && x2 == -1) {
            canvas.drawPoints(PointMode.points, [Offset(x1, y1)], paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: DrawingScreen(),
//     );
//   }
// }

// class DrawingScreen extends StatelessWidget {
//   const DrawingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('그림 그리기 팝업 예제'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => const DrawingPopup(),
//             );
//           },
//           child: const Text('팝업 열기'),
//         ),
//       ),
//     );
//   }
// }
