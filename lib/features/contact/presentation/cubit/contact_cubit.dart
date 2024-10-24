import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/mixins/cubit_scrolling_mixin.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/contact.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/check_contact_usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/get_contact_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState>
    with CubitScrollingMixin<EunoiaContact, GetContactsHelper> {
  GetContactUsecase getContactUsecase;
  CheckContactUsecase checkContactUsecase;
  ContactCubit({
    required this.getContactUsecase,
    required this.checkContactUsecase,
  }) : super(ContactInitial()) {
    helperClass = GetContactsHelper(phoneNumbers: []);
  }

  getContacts({
    GetContactsHelper? helper,
    bool refreshScroll = false,
  }) async {
    helperClass = helperClass.copyWith(
      phoneNumbers: await getLocalContacts(),
    );
    if (!hasMore) return;

    if (refreshScroll) refresh();

    if (helper != null) helperClass = helper;

    helperClass = helperClass.copyWith(
      offset: fetchedData.length,
    );

    emit(ContactsLoading());

    final response = await getContactUsecase(helperClass);

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

  Future<List<String>> getLocalContacts() async {
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );

      List<String> allNumbers = [];

      for (var i = 0; i < contacts.length; i++) {
        for (var j = 0; j < contacts[i].phones.length; j++) {
          allNumbers.add(contacts[i].phones[j].number);
        }
      }
      return allNumbers;
    } else {
      return [];
    }
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
