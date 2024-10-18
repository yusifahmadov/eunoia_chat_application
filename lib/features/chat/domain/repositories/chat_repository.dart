import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';

abstract class ChatRepository {
  Future<Either<ResponseI, List<Conversation>>> getConversations(String userId);
}
