import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/helper/listen_message_helper.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

class ListenMessagesUsecase extends Usecase<Message?, ListenMessageHelper> {
  final MessageRepository messageRepository;

  ListenMessagesUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, Message?>> call(params) {
    return messageRepository.listenMessages(body: params);
  }
}
