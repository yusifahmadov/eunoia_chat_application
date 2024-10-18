import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/helper/get_conversations_helper.dart';

abstract class ChatRepository {
  Future<Either<ResponseI, List<Conversation>>> getConversations(
      GetConversationsHelper body);
  Future<Either<ResponseI, Conversation?>> listenConversations(
      void Function({required Conversation conversation}) callBackFunc);
}
