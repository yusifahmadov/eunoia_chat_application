class SendGroupMessageHelper {
  final int groupId;
  final String message;

  SendGroupMessageHelper({
    required this.groupId,
    required this.message,
  });

  toJson() {
    return {
      'p_group_id': groupId,
      'message_text': message,
    };
  }

  copyWith({
    int? groupId,
    String? message,
  }) {
    return SendGroupMessageHelper(
      groupId: groupId ?? this.groupId,
      message: message ?? this.message,
    );
  }
}
