import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/contact.dart';
import '../entities/helper/get_contacts_helper.dart';
import '../repositories/contact_repository.dart';

class GetContactUsecase extends Usecase<List<EunoiaContact>, GetContactsHelper> {
  ContactRepository contactRepository;

  GetContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, List<EunoiaContact>>> call(GetContactsHelper params) {
    return contactRepository.getContacts(body: params);
  }
}
