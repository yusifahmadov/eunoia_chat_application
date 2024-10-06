import 'package:eunoia_chat_application/core/response/response.dart';

class ResponseModel extends ResponseI {
  ResponseModel({required super.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
