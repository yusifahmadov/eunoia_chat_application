import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_encryption_request_helper.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/message_repository.dart';

class SendEncryptionRequestUsecase
    extends Usecase<ResponseI, SendEncryptionRequestHelper> {
  final MessageRepository messageRepository;

  SendEncryptionRequestUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, ResponseI>> call(params) {
    return messageRepository.sendEncryptionRequest(params);
  }
}
