import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/repositories/contact_repository.dart';

class CheckContactUsecase extends Usecase<int, String> {
  ContactRepository contactRepository;

  CheckContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, int>> call(String params) {
    return contactRepository.checkContact(contactId: params);
  }
}
