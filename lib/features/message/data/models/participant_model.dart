import 'package:eunoia_chat_application/features/message/data/models/encryption_request_model.dart';
import 'package:eunoia_chat_application/features/user/data/models/user_model.dart';

import '../../domain/entities/participant.dart';

class ParticipantModel extends Participant {
  const ParticipantModel({required super.userData, required super.encryptionRequestData});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      encryptionRequestData: json['encryption_request_data'] != null
          ? EncryptionRequestModel.fromJson(
              json['encryption_request_data'] as Map<String, dynamic>)
          : null,
      userData: UserModel.fromJson(json['user_data'] as Map<String, dynamic>),
    );
  }

  toJson() {
    return {
      'user_data': super.userData.toJson(),
      'encryption_request_data': (super.encryptionRequestData)?.toJson(),
    };
  }
}
