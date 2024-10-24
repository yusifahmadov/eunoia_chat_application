import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/contact.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/contact/domain/repositories/contact_repository.dart';

class GetContactUsecase extends Usecase<List<EunoiaContact>, GetContactsHelper> {
  ContactRepository contactRepository;

  GetContactUsecase({required this.contactRepository});

  @override
  Future<Either<ResponseI, List<EunoiaContact>>> call(GetContactsHelper params) {
    return contactRepository.getContacts(body: params);
  }
}
