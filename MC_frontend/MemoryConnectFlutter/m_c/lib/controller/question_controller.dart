import 'package:get/get.dart';

class QuestionController extends GetxController {
  RxList captions = [].obs; // 질문 데이터를 자막처럼 저장하는 리스트
  RxList videoUrl = [].obs; // 비디오 주소

  RxBool isListening = false.obs;

  RxString tempAnswer = "".obs;
  RxBool drawingAnswer = false.obs;
}
