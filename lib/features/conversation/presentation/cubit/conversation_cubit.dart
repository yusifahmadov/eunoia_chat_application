import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/encryption/diffie_hellman_encryption.dart';
import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/group_data.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_group_photo_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_participants_to_group_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/make_group_conversation_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/add_group_photo_usecase.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/add_participants_to_group_usecase.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/get_group_data_usecase.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/leave_group_usecase.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/make_group_conversation_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/mixins/cubit_scrolling_mixin.dart';
import '../../../../core/shared_preferences/shared_preferences_user_manager.dart';
import '../../../../injection.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/helper/get_conversations_helper.dart';
import '../../domain/usecases/get_conversations_usecase.dart';
import '../../domain/usecases/listen_conversations_usecase.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState>
    with CubitScrollingMixin<Conversation, GetConversationsHelper> {
  GetConversationsUsecase getConversationsUsecase;
  ListenConversationsUsecase listenConversationsUsecase;
  AddParticipantsToGroupUsecase addParticipantsToGroupUsecase;
  MakeGroupConversationUsecase makeGroupConversationUsecase;
  AddGroupPhotoUsecase addGroupPhotoUsecase;
  GetGroupDataUsecase getGroupDataUsecase;
  LeaveGroupUsecase laeveGroupUsecase;

  ConversationCubit(
      {required this.getConversationsUsecase,
      required this.listenConversationsUsecase,
      required this.addParticipantsToGroupUsecase,
      required this.makeGroupConversationUsecase,
      required this.getGroupDataUsecase,
      required this.addGroupPhotoUsecase,
      required this.laeveGroupUsecase})
      : super(ConversationInitial()) {
    helperClass = GetConversationsHelper();
  }

  getConversations(
      {GetConversationsHelper? helper,
      bool isUIRefresh = false,
      bool refreshScroll = false}) async {
    isLoading = true;
    if (isUIRefresh) {
      emit(ConversationsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConversationsLoaded(conversations: fetchedData));
    }
    final String? id = (await SharedPreferencesUserManager.getUser())?.user.id;
    if (id == null) {
      return emit(
          ConversationsError(message: mainContext!.localization?.user_not_found ?? ""));
    }
    if (!hasMore) return;
    if (helper != null) helperClass = helper;
    if (refreshScroll) refresh();

    emit(ConversationsLoading());

    helperClass = helperClass.copyWith(offset: fetchedData.length, userId: id);

    final response = getConversationsUsecase.call(helperClass);

    response.then((value) async {
      value.fold(
        (error) {
          fetchedData.clear();
          emit(ConversationsError(message: error.message));
        },
        (conversations) async {
          isFirstFetching = false;
          for (var i = 0; i < conversations.length; i++) {
            if (conversations[i].lastMessage == null ||
                conversations[i].lastMessageOwnerPublicKey == null) {
              continue;
            }
            final String? message = await decryptLastMessage(
              lastMessage: conversations[i].lastMessage!,
              otherPartyPublicKey: BigInt.parse(
                conversations[i].lastMessageOwnerPublicKey!,
              ),
            );

            conversations[i] = conversations[i].copyWith(
                lastMessage: conversations[i].lastMessage!.copyWith(message: message));
          }
          fetchedData.addAll(conversations);

          hasMore = conversations.isNotEmpty;
          isLoading = false;

          emit(ConversationsLoaded(conversations: conversations));
        },
      );
    });
  }

  Future<String?> decryptLastMessage({
    required Message lastMessage,
    required BigInt? otherPartyPublicKey,
  }) async {
    if (otherPartyPublicKey == null) {
      return null;
    }

    BigInt sharedSecret = await DiffieHellmanEncryption.generateSharedSecret(
        receiverPublicKey: otherPartyPublicKey);
    String? message = lastMessage.message;
    if (lastMessage.encrypted) {
      message = await DiffieHellmanEncryption.decryptMessageRCase(
          secretKey: sharedSecret, message: lastMessage.message);
      message ??= 'Message could not be decrypted';
    }

    lastMessage = lastMessage.copyWith(message: message);
    return lastMessage.message;
  }

  listenConversations() async {
    final response = listenConversationsUsecase.call(refreshConversations);

    response.then((value) {
      value.fold(
        (error) => emit(ConversationsError(message: error.message)),
        (conversation) {},
      );
    });
  }

  void refreshConversations({required Conversation conversation}) async {
    final String? id = (await SharedPreferencesUserManager.getUser())?.user.id;
    if (id == null) {
      return emit(
          ConversationsError(message: mainContext!.localization?.user_not_found ?? ""));
    }
    if (conversation.lastMessage == null) {
      emit(ConversationsLoading());

      fetchedData.insert(0, conversation);
      emit(ConversationsLoaded(conversations: fetchedData));
      return;
    }
    final index = fetchedData.indexWhere((element) => element.id == conversation.id);

    if (conversation.lastMessage?.message != null &&
        conversation.lastMessage?.message != "" &&
        conversation.lastMessage?.encrypted == true) {
      conversation = conversation.copyWith(
          lastMessage:
              conversation.lastMessage!.copyWith(message: 'Message is encrypted'));
    }

    emit(ConversationsLoading());

    conversation = (fetchedData[index] as ConversationModel).copyWith(
      lastMessage: conversation.lastMessage,
    );

    fetchedData.removeAt(index);
    fetchedData.insert(0, conversation);
    emit(ConversationsLoaded(conversations: fetchedData));
  }

  makeGroupConversation(
      {required MakeGroupConversationHelper body,
      required AddParticipantsToGroupHelper participantsHelper,
      required AddGroupPhotoHelper? addGroupPhotoHelper,
      void Function()? whenSuccess}) async {
    final response = makeGroupConversationUsecase.call(body);

    response.then((value) {
      value.fold(
        (error) {
          print(error.message);
        },
        (response) async {
          participantsHelper = participantsHelper.copyWith(groupId: response);

          if (addGroupPhotoHelper != null && addGroupPhotoHelper.fileName != '') {
            print('WE CANNOT BE HERE');
            await addGroupPhoto(body: addGroupPhotoHelper);
          }

          addParticipantsToGroupConversation(
              body: participantsHelper, whenSuccess: whenSuccess);
        },
      );
    });
  }

  addParticipantsToGroupConversation(
      {required AddParticipantsToGroupHelper body,
      void Function()? whenSuccess,
      bool fromExistingGroup = false}) async {
    final response = await addParticipantsToGroupUsecase.call(body);

    response.fold(
      (error) {
        print(error.message);
      },
      (response) {
        fromExistingGroup
            ? getGroupData(conversationId: body.groupId)
            : getConversations(refreshScroll: true);
        whenSuccess?.call();
      },
    );
  }

  Future<GroupData?> getGroupData({required int conversationId}) async {
    emit(GroupDataLoading());
    final response = await getGroupDataUsecase(conversationId);
    GroupData? tmpGroupData;
    response.fold(
      (l) {
        tmpGroupData = null;
        emit(GroupDataError(message: l.message));
      },
      (r) {
        tmpGroupData = r.first;
        emit(GroupDataLoaded(groupData: r));
      },
    );

    return tmpGroupData;
  }

  addGroupPhoto({required AddGroupPhotoHelper body}) async {
    final response = await addGroupPhotoUsecase(body);
    response.fold(
      (l) {
        print(l.message);
      },
      (r) {},
    );
  }

  leaveGroup({required int conversationId, required void Function()? whenSuccess}) async {
    final response = await laeveGroupUsecase(conversationId);
    response.fold(
      (l) {
        print(l.message);
      },
      (r) {
        getConversations(refreshScroll: true);
        whenSuccess?.call();
      },
    );
  }
}
