class SetPublicKeyHelper {
  final String publicKey;
  final bool forceChange;

  SetPublicKeyHelper({
    required this.publicKey,
    required this.forceChange,
  });

  SetPublicKeyHelper copyWith({
    String? publicKey,
    bool? forceChange,
  }) {
    return SetPublicKeyHelper(
      publicKey: publicKey ?? this.publicKey,
      forceChange: forceChange ?? this.forceChange,
    );
  }

  toJson() {
    return {
      "new_public_key": publicKey,
      "force_change": forceChange,
    };
  }
}
