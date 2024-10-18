import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? createdAt;
  final String? profilePhoto;
  final String? phoneNumber;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.profilePhoto,
    required this.phoneNumber,
  });
  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, createdAt, profilePhoto, phoneNumber];
}
