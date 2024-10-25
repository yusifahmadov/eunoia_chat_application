import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/contact.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';

abstract class ContactRepository {
  Future<Either<ResponseI, List<EunoiaContact>>> getContacts(
      {required GetContactsHelper body});

  Future<Either<ResponseI, int>> checkContact({required String contactId});
  Future<Either<ResponseI, List<User>>> searchContacts({required GetContactsHelper body});
}
