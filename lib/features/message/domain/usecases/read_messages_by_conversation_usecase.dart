import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/helper/read_messages_helper.dart';
import '../repositories/message_repository.dart';

class ReadMessagesByConversationUsecase extends Usecase<void, ReadMessagesHelper> {
  final MessageRepository messageRepository;

  ReadMessagesByConversationUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return messageRepository.readMessagesByConversation(body: params);
  }
}
