import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/contact/domain/repositories/contact_repository.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';

class SearchContactUsecase extends Usecase<List<User>, GetContactsHelper> {
  ContactRepository contactRepository;

  SearchContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, List<User>>> call(GetContactsHelper params) {
    return contactRepository.searchContacts(body: params);
  }
}
