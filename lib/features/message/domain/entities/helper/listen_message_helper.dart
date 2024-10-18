import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';

class ListenMessageHelper {
  final void Function({required Message message}) callBackFunc;
  final int conversationId;

  ListenMessageHelper({
    required this.callBackFunc,
    required this.conversationId,
  });

  ListenMessageHelper copyWith({
    void Function({required Message message})? callBackFunc,
    int? conversationId,
  }) {
    return ListenMessageHelper(
      callBackFunc: callBackFunc ?? this.callBackFunc,
      conversationId: conversationId ?? this.conversationId,
    );
  }
}
