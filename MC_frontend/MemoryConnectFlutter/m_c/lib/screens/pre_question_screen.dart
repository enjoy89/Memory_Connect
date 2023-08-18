import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreQuestionScreen extends StatefulWidget {
  const PreQuestionScreen({super.key});

  @override
  State<PreQuestionScreen> createState() => _PreQuestionScreenState();
}

class _PreQuestionScreenState extends State<PreQuestionScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // 웹용 VideoPlayerController 생성
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        "https://careerup-client.s3.ap-northeast-2.amazonaws.com/KakaoTalk_Video_2023-08-15-14-52-52.mp4"));
    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Q. 성함을 말씀해주세요.",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Center(
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasError) {
                    _controller.play(); // 바로 재생하도록.
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    print(snapshot.error);
                    return const CircularProgressIndicator(); // 로딩 중 표시
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PreQuestionScreen()));
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                ),
              ),
              child: const Text(
                '대답하기',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
