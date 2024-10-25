import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/mixins/cubit_scrolling_mixin.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/check_contact_usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/get_contact_usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/search_contact_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState>
    with CubitScrollingMixin<User, GetContactsHelper> {
  GetContactUsecase getContactUsecase;
  CheckContactUsecase checkContactUsecase;
  SearchContactUsecase searchContactUsecase;
  ContactCubit({
    required this.getContactUsecase,
    required this.checkContactUsecase,
    required this.searchContactUsecase,
  }) : super(ContactInitial()) {
    helperClass = GetContactsHelper(username: '');
  }

  getContacts({
    GetContactsHelper? helper,
    bool refreshScroll = false,
  }) async {
    if (refreshScroll) refresh();

    if (!hasMore) return;

    if (helper != null) helperClass = helper;

    helperClass = helperClass.copyWith(
      offset: fetchedData.length,
    );

    emit(ContactsLoading());

    final response = await searchContactUsecase(helperClass);
    response.fold(
      (error) {
        fetchedData.clear();
        emit(ContactsError(message: error.message));
      },
      (contacts) {
        isFirstFetching = false;
        isLoading = false;
        fetchedData.addAll(contacts);
        hasMore = contacts.isNotEmpty;

        emit(ContactsLoaded(contacts: fetchedData));
      },
    );
  }

  Future<int?> checkContact({required String id}) async {
    final response = await checkContactUsecase(id);
    int? tmpId;
    response.fold(
      (error) {
        return null;
      },
      (contact) {
        tmpId = contact;
      },
    );
    return tmpId;
  }
}
