import 'dart:io';

class AddGroupPhotoHelper {
  final String fileName;
  final File file;

  AddGroupPhotoHelper({required this.fileName, required this.file});

  toJson() {
    return {
      'file_name': fileName,
      'file': file,
    };
  }

  copyWith({String? fileName, File? file}) {
    return AddGroupPhotoHelper(
      fileName: fileName ?? this.fileName,
      file: file ?? this.file,
    );
  }
}
