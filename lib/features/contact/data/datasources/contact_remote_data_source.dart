import 'package:eunoia_chat_application/features/contact/data/models/contact_model.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';

abstract class ContactRemoteDataSource {
  Future<List<EunoiaContactModel>> getContacts({required GetContactsHelper body});

  Future<int> checkContact({required String contactId});
}
