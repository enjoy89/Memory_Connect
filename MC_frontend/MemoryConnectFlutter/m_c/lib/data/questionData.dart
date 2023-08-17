class questionData {
  final int testId;
  final String testQuestion;

  questionData({required this.testId, required this.testQuestion});

  factory questionData.fromJson(Map<String, dynamic> json) {
    return questionData(
      testId: json['test_id'] ?? 0, // 기본값을 지정하거나, 허용하지 않을 경우 에러 처리
      testQuestion: json['question'] ?? '',
    );
  }
}