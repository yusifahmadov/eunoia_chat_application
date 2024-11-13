import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/helper/read_messages_helper.dart';
import '../repositories/message_repository.dart';

class ReadMessagesUsecase extends Usecase<void, ReadMessagesHelper> {
  final MessageRepository messageRepository;

  ReadMessagesUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return messageRepository.readMessages(body: params);
  }
}
