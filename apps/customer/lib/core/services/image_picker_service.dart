import 'dart:io';

abstract class ImagePickerService {
  Future<File?> pickFromGallery();
  Future<File?> pickFromCamera();
}
