import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/get_conversations_helper.dart';

abstract class ConversationRepository {
  Future<Either<ResponseI, List<Conversation>>> getConversations(
      GetConversationsHelper body);
  Future<Either<ResponseI, Conversation?>> listenConversations(
      void Function({required Conversation conversation}) callBackFunc);
}
