import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/message/data/models/encryption_request_model.dart';
import 'package:eunoia_chat_application/features/user/data/models/user_model.dart';

class Participant extends Equatable {
  final UserModel userData;

  final EncryptionRequestModel? encryptionRequestData;

  const Participant({
    required this.userData,
    this.encryptionRequestData,
  });

  @override
  List<Object?> get props => [userData, encryptionRequestData];
}
