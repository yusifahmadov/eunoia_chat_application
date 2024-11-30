import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/user/data/models/user_model.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final String? profilePhoto;
  final String? bio;
  final String? username;
  final String? publicKey;
  final bool? e2eeEnabled;
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.createdAt,
      required this.profilePhoto,
      required this.e2eeEnabled,
      required this.bio,
      required this.publicKey,
      required this.username});
  @override
  List<Object?> get props => [id, name, email, createdAt, profilePhoto, bio];

  copyWith(
      {String? id,
      String? name,
      String? email,
      DateTime? createdAt,
      String? profilePhoto,
      String? bio,
      String? username,
      String? publicKey,
      bool? e2eeEnabled}) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        bio: bio ?? this.bio,
        username: username ?? this.username,
        publicKey: publicKey ?? this.publicKey,
        e2eeEnabled: e2eeEnabled ?? this.e2eeEnabled);
  }
}
