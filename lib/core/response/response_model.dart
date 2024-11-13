import 'response.dart';

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
