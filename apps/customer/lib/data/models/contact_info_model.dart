import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/store.dart';

part 'contact_info_model.freezed.dart';
part 'contact_info_model.g.dart';

@freezed
class ContactInfoModel with _$ContactInfoModel {
  const factory ContactInfoModel({
    required String provider,
    required ContactType type,
  }) = _ContactInfoModel;

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ContactInfoModelFromJson(json);
}
