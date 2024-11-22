class UpdateUserInformationHelper {
  final String name;
  final String bio;

  UpdateUserInformationHelper({
    required this.name,
    required this.bio,
  });

  UpdateUserInformationHelper copyWith({
    String? name,
    String? bio,
  }) {
    return UpdateUserInformationHelper(
      name: name ?? this.name,
      bio: bio ?? this.bio,
    );
  }

  toJson() {
    return {
      "new_name": name,
      "new_bio": bio,
    };
  }
}
