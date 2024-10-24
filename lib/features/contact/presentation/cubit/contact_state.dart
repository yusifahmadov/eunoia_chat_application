part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactsLoading extends ContactState {}

class ContactsLoaded extends ContactState {
  final List<EunoiaContact> contacts;

  const ContactsLoaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class ContactsError extends ContactState {
  final String message;

  const ContactsError({required this.message});

  @override
  List<Object> get props => [message];
}
