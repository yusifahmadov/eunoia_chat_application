import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../entities/conversation.dart';
import '../entities/helper/get_conversations_helper.dart';

abstract class ConversationRepository {
  Future<Either<ResponseI, List<Conversation>>> getConversations(
      GetConversationsHelper body);
  Future<Either<ResponseI, Conversation?>> listenConversations(
      void Function({required Conversation conversation}) callBackFunc);
}
