import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final String? profilePhoto;
  final String? bio;
  final String? username;
  final String? publicKey;
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.createdAt,
      required this.profilePhoto,
      required this.bio,
      required this.publicKey,
      required this.username});
  @override
  List<Object?> get props => [id, name, email, createdAt, profilePhoto, bio];
}
