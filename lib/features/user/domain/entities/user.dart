import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final String? profilePhoto;
  final String? phoneNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.profilePhoto,
    required this.phoneNumber,
  });
  @override
  List<Object?> get props => [id, name, email, createdAt, profilePhoto, phoneNumber];
}
