import 'dart:io';

import 'package:dio/dio.dart';

class CreateStoreRequest {
  final String name;
  final String description;
  final String city;
  final String country;
  final List<String> categoryIds;
  final File avatarImage;
  final File coverImage;

  const CreateStoreRequest({
    required this.name,
    required this.description,
    required this.city,
    required this.country,
    required this.categoryIds,
    required this.avatarImage,
    required this.coverImage,
  });

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'title': name,
      'description': description,
      'city': city,
      'country': country,
      'avatarImage': await MultipartFile.fromFile(
        avatarImage.path,
        filename: avatarImage.path.split('/').last,
      ),
      'coverImage': await MultipartFile.fromFile(
        coverImage.path,
        filename: coverImage.path.split('/').last,
      ),
    });

    for (final id in categoryIds) {
      formData.fields.add(MapEntry('categoryIds', id));
    }

    return formData;
  }
}
