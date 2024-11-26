import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/conversation/data/models/group_data_model.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_group_photo_helper.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/supabase/supabase_repository.dart';
import '../../../../injection.dart';
import '../../domain/entities/helper/get_conversations_helper.dart';
import '../models/conversation_model.dart';
import 'conversation_remote_data_source.dart';

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  @override
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body}) async {
    final response = await getIt<Dio>().get(
      '/rest/v1/rpc/get_user_conversations?user_id=${body.userId}&limit_count=${body.limit}&offset_count=${body.offset}&search_name=${body.fullName}}',
    );

    return (response.data as List)
        .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation})
          callBackFunc}) async {
    return await SupabaseRepository.listenConversations(callBackFunc: callBackFunc);
  }

  @override
  Future<void> addParticipantsToGroupConversation(
      {required Map<String, dynamic> body}) async {
    await getIt<Dio>().post(
      '/rest/v1/rpc/add_participants_to_group',
      data: body,
    );
  }

  @override
  Future<int> makeGroupConversation({required Map<String, dynamic> body}) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/create_group',
      data: body,
    );

    return response.data as int;
  }

  @override
  Future<List<GroupDataModel>> getGroupData(int conversationId) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/get_group_data',
      data: {'p_conversation_id': conversationId},
    );

    return (response.data as List)
        .map((e) => GroupDataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addGroupPhoto({required AddGroupPhotoHelper body}) async {
    final data = FormData();
    data.files.add(MapEntry(
      'body',
      MultipartFile.fromFileSync(
        body.file.path,
        filename: '${body.fileName}.jpg',
        contentType: MediaType.parse('image/jpeg'),
      ),
    ));
    await getIt<Dio>()
        .post('/storage/v1/object/groups/${'${body.fileName}.jpg'}', data: data);
  }
}
