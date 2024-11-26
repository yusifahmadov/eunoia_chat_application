import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/contact_repository.dart';

class CheckContactUsecase extends Usecase<Conversation, String> {
  ContactRepository contactRepository;

  CheckContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, Conversation>> call(String params) {
    return contactRepository.checkContact(contactId: params);
  }
}
