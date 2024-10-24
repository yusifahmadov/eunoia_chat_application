class ReadMessagesHelper {
  final String userId;
  final List<int>? messageIds;
  final int? conversationId;

  ReadMessagesHelper({required this.userId, this.messageIds, this.conversationId});

  ReadMessagesHelper copyWith({
    String? userId,
    List<int>? messageIds,
  }) {
    return ReadMessagesHelper(
      userId: userId ?? this.userId,
      messageIds: messageIds ?? this.messageIds,
    );
  }

  toJson() {
    return {
      "p_user_id": userId,
      "message_ids": messageIds,
    };
  }

  toJsonForReadAll() {
    return {
      "p_user_id": userId,
      "p_conversation_id": conversationId,
    };
  }
}
