import 'dart:io';

class MakeGroupConversationHelper {
  final String title;
  final File? image;

  MakeGroupConversationHelper({required this.title, this.image});

  toJson() {
    return {
      'p_title': title,
    };
  }

  copyWith({String? title, File? image}) {
    return MakeGroupConversationHelper(
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }
}
