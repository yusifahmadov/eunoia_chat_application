class HandleEncryptionRequestHelper {
  final int requestId;
  final bool answer;
  final int conversationId;
  HandleEncryptionRequestHelper(
      {required this.requestId, required this.answer, required this.conversationId});

  Map<String, dynamic> toJson() {
    return {'request_id': requestId, 'answer': answer};
  }

  copyWith({int? requestId, bool? answer, int? conversationId}) {
    return HandleEncryptionRequestHelper(
      requestId: requestId ?? this.requestId,
      answer: answer ?? this.answer,
      conversationId: conversationId ?? this.conversationId,
    );
  }
}
