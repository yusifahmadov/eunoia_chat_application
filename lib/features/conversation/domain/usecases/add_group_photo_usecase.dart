import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_group_photo_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/repositories/conversation_repository.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';

class AddGroupPhotoUsecase extends Usecase<void, AddGroupPhotoHelper> {
  ConversationRepository conversationRepository;

  AddGroupPhotoUsecase({required this.conversationRepository});

  @override
  Future<Either<ResponseI, void>> call(AddGroupPhotoHelper params) {
    return conversationRepository.addGroupPhoto(params);
  }
}
