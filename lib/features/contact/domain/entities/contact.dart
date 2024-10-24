import 'package:equatable/equatable.dart';

class EunoiaContact extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? profilePhoto;
  const EunoiaContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.profilePhoto,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, profilePhoto];
}
