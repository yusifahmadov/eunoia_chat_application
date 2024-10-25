import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/contact/data/datasources/contact_remote_data_source.dart';
import 'package:eunoia_chat_application/features/contact/data/models/contact_model.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/user/data/models/user_model.dart';
import 'package:eunoia_chat_application/injection.dart';

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  @override
  Future<List<EunoiaContactModel>> getContacts({required GetContactsHelper body}) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/get_users_by_phone',
      data: body.toJson(),
    );

    return (response.data as List).map((e) => EunoiaContactModel.fromJson(e)).toList();
  }

  @override
  Future<int> checkContact({required String contactId}) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/check_or_create_conversation',
      data: {
        'contact_user_id': contactId,
      },
    );

    return response.data as int;
  }

  @override
  Future<List<UserModel>> searchContacts({required GetContactsHelper body}) async {
    final response = await getIt<Dio>().get(
      '/rest/v1/rpc/search_users_by_username?username_input=${body.username}&limit_input=${body.limit}&offset_input=${body.offset}',
    );

    return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
  }
}
