import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/contact_repository.dart';

class CheckContactUsecase extends Usecase<int, String> {
  ContactRepository contactRepository;

  CheckContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, int>> call(String params) {
    return contactRepository.checkContact(contactId: params);
  }
}
