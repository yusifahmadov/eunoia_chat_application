import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/group_data.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_group_photo_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_participants_to_group_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/make_group_conversation_helper.dart';

import '../../../../core/response/response.dart';
import '../entities/conversation.dart';
import '../entities/helper/get_conversations_helper.dart';

abstract class ConversationRepository {
  Future<Either<ResponseI, List<Conversation>>> getConversations(
      GetConversationsHelper body);
  Future<Either<ResponseI, Conversation?>> listenConversations(
      void Function({required Conversation conversation}) callBackFunc);

  Future<Either<ResponseI, int>> makeGroupConversation(MakeGroupConversationHelper body);
  Future<Either<ResponseI, void>> addParticipantsToGroupConversation(
      AddParticipantsToGroupHelper body);

  Future<Either<ResponseI, List<GroupData>>> getGroupData(int conversationId);
  Future<Either<ResponseI, void>> addGroupPhoto(AddGroupPhotoHelper body);
  Future<Either<ResponseI, ResponseI>> leaveGroup(int conversationId);
}
