class SendMessageHelper {
  String senderId;
  int conversationId;
  String messageText;

  SendMessageHelper({
    required this.senderId,
    required this.conversationId,
    required this.messageText,
  });

  toJson() {
    return {
      'p_sender_id': senderId,
      'p_conversation_id': conversationId,
      'p_message_text': messageText,
    };
  }
}
