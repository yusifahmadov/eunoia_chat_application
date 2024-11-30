class UploadUserProfilePhotoHelper {
  final String fileName;
  final List<int> fileBytes;

  UploadUserProfilePhotoHelper({required this.fileName, required this.fileBytes});

  copyWith({
    String? fileName,
    List<int>? fileBytes,
  }) {
    return UploadUserProfilePhotoHelper(
      fileName: fileName ?? this.fileName,
      fileBytes: fileBytes ?? this.fileBytes,
    );
  }
}
