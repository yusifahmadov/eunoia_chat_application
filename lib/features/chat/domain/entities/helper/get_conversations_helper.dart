class GetConversationsHelper {
  final String userId;
  final String fullName;
  final int limit;
  final int offset;

  GetConversationsHelper({
    this.fullName = '',
    this.userId = '',
    this.limit = 30,
    this.offset = 0,
  });

  toMap() {
    return {
      'search_name': fullName,
      'limit': limit,
      'offset': offset,
    };
  }

  copyWith({
    String? userId,
    String? fullName,
    int? limit,
    int? offset,
  }) {
    return GetConversationsHelper(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  toString() {
    return 'GetConversationsHelper(userId: $userId, fullName: $fullName, limit: $limit, offset: $offset)';
  }
}
