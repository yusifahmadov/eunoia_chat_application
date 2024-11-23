import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';

class ListenEncryptionRequestsHelper {
  final void Function({required EncryptionRequest request}) callBackFunc;

  final int conversationId;
  final bool? answer;

  ListenEncryptionRequestsHelper({
    required this.callBackFunc,
    required this.conversationId,
    required this.answer,
  });

  ListenEncryptionRequestsHelper copyWith({
    void Function({required EncryptionRequest request})? callBackFunc,
    int? conversationId,
    bool? answer,
  }) {
    return ListenEncryptionRequestsHelper(
      callBackFunc: callBackFunc ?? this.callBackFunc,
      conversationId: conversationId ?? this.conversationId,
      answer: answer ?? this.answer,
    );
  }

  toJson() {
    return {
      'callBackFunc': callBackFunc,
      'conversationId': conversationId,
      'answer': answer,
    };
  }
}
