class GetContactsHelper {
  final List<String> phoneNumbers;
  final int limit;
  final int offset;

  GetContactsHelper({
    required this.phoneNumbers,
    this.limit = 30,
    this.offset = 0,
  });

  GetContactsHelper copyWith({
    List<String>? phoneNumbers,
    int? limit,
    int? offset,
  }) {
    return GetContactsHelper(
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  toJson() {
    return {
      'phone_numbers': phoneNumbers,
      'limit_count': limit,
      'offset_count': offset,
    };
  }
}
