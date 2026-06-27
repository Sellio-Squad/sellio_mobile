import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'image_picker_service.dart';

class ImagePickerServiceImpl implements ImagePickerService {
  final ImagePicker _picker;

  ImagePickerServiceImpl({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  @override
  Future<File?> pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  @override
  Future<File?> pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
