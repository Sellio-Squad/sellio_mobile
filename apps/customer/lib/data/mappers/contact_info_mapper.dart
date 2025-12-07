import '../../domain/entities/store.dart';
import '../models/contact_info_model.dart';

extension ContactInfoModelMapper on ContactInfoModel {
  ContactInfo toEntity() {
    return ContactInfo(
      provider: provider,
      type: type,
    );
  }
}
