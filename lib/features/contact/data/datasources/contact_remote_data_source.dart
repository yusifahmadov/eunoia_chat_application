import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';

import '../../../user/data/models/user_model.dart';
import '../../domain/entities/helper/get_contacts_helper.dart';
import '../models/contact_model.dart';

abstract class ContactRemoteDataSource {
  Future<List<EunoiaContactModel>> getContacts({required GetContactsHelper body});

  Future<ConversationModel> checkContact({required String contactId});

  Future<List<UserModel>> searchContacts({required GetContactsHelper body});
}
