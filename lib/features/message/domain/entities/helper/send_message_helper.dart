class SendMessageHelper {
  String senderId;
  String messageText;
  String receiverId;
  bool isGroup;
  SendMessageHelper(
      {required this.senderId,
      required this.messageText,
      required this.receiverId,
      required this.isGroup});

  toJson() {
    return {
      'p_sender_id': senderId,
      'p_receiver_id': receiverId,
      'message_text': messageText
    };
  }
}
