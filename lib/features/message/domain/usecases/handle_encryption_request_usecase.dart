import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/handle_encryption_request_helper.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/message_repository.dart';

class HandleEncryptionRequestUsecase
    extends Usecase<ResponseI, HandleEncryptionRequestHelper> {
  final MessageRepository messageRepository;

  HandleEncryptionRequestUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, ResponseI>> call(params) {
    return messageRepository.handleEncryptionRequest(body: params);
  }
}
