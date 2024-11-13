import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/helper/get_message_helper.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

class GetMessagesUsecase extends Usecase<List<Message>, GetMessageHelper> {
  final MessageRepository messageRepository;

  GetMessagesUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, List<Message>>> call(params) {
    return messageRepository.getMessages(body: params);
  }
}
