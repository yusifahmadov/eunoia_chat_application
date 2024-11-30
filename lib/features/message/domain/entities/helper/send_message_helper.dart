class SendMessageHelper {
  String senderId;
  String messageText;
  String receiverId;
  bool isGroup;
  int conversationId;
  SendMessageHelper(
      {required this.senderId,
      required this.conversationId,
      required this.messageText,
      required this.receiverId,
      required this.isGroup});

  toJson() {
    return {
      'p_sender_id': senderId,
      'p_receiver_id': receiverId,
      'message_text': messageText,
      'p_conversation_id': conversationId,
    };
  }
}
