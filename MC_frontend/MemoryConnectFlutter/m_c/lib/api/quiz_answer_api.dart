// import 'package:json_annotation/json_annotation.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart';

// //part 'example.g.dart';

// @RestApi(baseUrl: "https://")
// abstract class QuizAnswerApi {
//   factory QuizAnswerApi(Dio dio, {String baseUrl}) = _QuizAnswerApi;

//   @POST("/나중에추가/")
//   Future<Answer> postAnswer();
// }

// @JsonSerializable()
// class Answer {
//   String? name;
//   int? id;
//   String? answer;

//   Answer({this.name, this.id, this.answer});

//   factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
//   Map<String, dynamic> toJson() => _$AnswerToJson(this);
// }

// 주소 (baseUrl 이랑 path ) 채운다음에
// generator 돌리기 부터 이어서 하기.