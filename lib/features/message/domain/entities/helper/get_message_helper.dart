class GetMessageHelper {
  final int conversationId;
  final int limit;
  final int offset;

  GetMessageHelper({
    required this.conversationId,
    this.limit = 30,
    this.offset = 0,
  });

  copyWith({
    int? conversationId,
    int? limit,
    int? offset,
  }) {
    return GetMessageHelper(
      conversationId: conversationId ?? this.conversationId,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
