import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.firstName,
      required super.phoneNumber,
      required super.profilePhoto,
      super.lastName,
      required super.email,
      required super.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']) as DateTime?
          : null,
      profilePhoto: json['profile_photo'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  toJson() {
    return {
      'id': super.id,
      'first_name': super.firstName,
      'last_name': super.lastName,
      'email': super.email,
      'created_at': super.createdAt?.toIso8601String(),
      'profile_photo': super.profilePhoto,
      'phone_number': super.phoneNumber,
    };
  }
}
