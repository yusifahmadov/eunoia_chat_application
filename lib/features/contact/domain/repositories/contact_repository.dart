import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';

import '../../../../core/response/response.dart';
import '../../../user/domain/entities/user.dart';
import '../entities/contact.dart';
import '../entities/helper/get_contacts_helper.dart';

abstract class ContactRepository {
  Future<Either<ResponseI, List<EunoiaContact>>> getContacts(
      {required GetContactsHelper body});

  Future<Either<ResponseI, Conversation>> checkContact({required String contactId});
  Future<Either<ResponseI, List<User>>> searchContacts({required GetContactsHelper body});
}
