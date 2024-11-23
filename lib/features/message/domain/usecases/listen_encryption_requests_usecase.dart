import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_encryption_requests_helper.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/message_repository.dart';

class ListenEncryptionRequestsUsecase
    extends Usecase<EncryptionRequest?, ListenEncryptionRequestsHelper> {
  final MessageRepository messageRepository;

  ListenEncryptionRequestsUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, EncryptionRequest?>> call(params) {
    return messageRepository.listenEncryptionRequests(params);
  }
}
