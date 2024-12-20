import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.bio,
      required super.profilePhoto,
      required super.email,
      required super.createdAt,
      required super.e2eeEnabled,
      required super.publicKey,
      required super.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']) as DateTime?
          : null,
      profilePhoto: json['profile_photo'] as String?,
      bio: json['bio'] as String?,
      publicKey: json['public_key'] as String?,
      e2eeEnabled: json['e2ee_enabled'] as bool?,
    );
  }

  toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'email': super.email,
      'created_at': super.createdAt?.toIso8601String(),
      'profile_photo': super.profilePhoto,
      'phone_number': super.bio,
      'username': super.username,
      'public_key': super.publicKey,
      'e2ee_enabled': super.e2eeEnabled,
    };
  }
}
