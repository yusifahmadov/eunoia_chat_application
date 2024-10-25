class GetContactsHelper {
  final String username;
  final int limit;
  final int offset;

  GetContactsHelper({
    required this.username,
    this.limit = 30,
    this.offset = 0,
  });

  GetContactsHelper copyWith({
    String? username,
    int? limit,
    int? offset,
  }) {
    return GetContactsHelper(
      username: username ?? this.username,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  toJson() {
    return {
      'username_input': username,
      'limit_input': limit,
      'offset_input': offset,
    };
  }
}
