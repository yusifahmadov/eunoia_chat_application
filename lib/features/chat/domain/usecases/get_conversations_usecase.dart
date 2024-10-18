import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/helper/get_conversations_helper.dart';
import 'package:eunoia_chat_application/features/chat/domain/repositories/chat_repository.dart';

class GetConversationsUsecase
    extends Usecase<List<Conversation>, GetConversationsHelper> {
  ChatRepository repository;

  GetConversationsUsecase({required this.repository});

  @override
  Future<Either<ResponseI, List<Conversation>>> call(params) {
    return repository.getConversations(params);
  }
}
