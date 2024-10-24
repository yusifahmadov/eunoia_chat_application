import 'package:eunoia_chat_application/features/contact/domain/entities/contact.dart';

class EunoiaContactModel extends EunoiaContact {
  const EunoiaContactModel(
      {required super.id,
      required super.name,
      required super.phoneNumber,
      required super.profilePhoto});

  factory EunoiaContactModel.fromJson(Map<String, dynamic> json) {
    return EunoiaContactModel(
      id: json['id'],
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      profilePhoto: json['profile_photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'phone_number': super.phoneNumber,
      'profile_photo': super.profilePhoto,
    };
  }
}
