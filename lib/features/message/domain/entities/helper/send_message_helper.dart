class SendMessageHelper {
  String senderId;
  String messageText;

  SendMessageHelper({
    required this.senderId,
    required this.messageText,
  });

  toJson() {
    return {
      'p_sender_id': senderId,
      'message_text': messageText,
    };
  }
}
