import 'dart:io';

class UploadUserProfilePhotoHelper {
  final String fileName;
  final File file;

  UploadUserProfilePhotoHelper({required this.fileName, required this.file});

  copyWith({
    String? fileName,
    File? file,
  }) {
    return UploadUserProfilePhotoHelper(
      fileName: fileName ?? this.fileName,
      file: file ?? this.file,
    );
  }
}
