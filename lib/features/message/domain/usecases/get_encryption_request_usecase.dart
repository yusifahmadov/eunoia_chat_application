import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/message_repository.dart';

class GetEncryptionRequestUsecase extends Usecase<List<EncryptionRequest>, int> {
  final MessageRepository messageRepository;

  GetEncryptionRequestUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, List<EncryptionRequest>>> call(params) {
    return messageRepository.getLastEncryption(params);
  }
}
