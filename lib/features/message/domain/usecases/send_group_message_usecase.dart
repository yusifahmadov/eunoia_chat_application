import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/send_group_message_helper.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/message_repository.dart';

class SendGroupMessageUsecase extends Usecase<void, SendGroupMessageHelper> {
  final MessageRepository messageRepository;

  SendGroupMessageUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return messageRepository.sendGroupMessage(params);
  }
}
