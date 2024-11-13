import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../user/domain/entities/user.dart';
import '../entities/helper/get_contacts_helper.dart';
import '../repositories/contact_repository.dart';

class SearchContactUsecase extends Usecase<List<User>, GetContactsHelper> {
  ContactRepository contactRepository;

  SearchContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, List<User>>> call(GetContactsHelper params) {
    return contactRepository.searchContacts(body: params);
  }
}
