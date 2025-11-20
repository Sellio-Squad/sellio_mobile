import '../../domain/entities/store.dart';

class ContactInfoModel extends ContactInfo {
  ContactInfoModel({
    required super.provider,
    required super.type,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      provider: json['provider'] as String,
      type: ContactType.values.firstWhere(
            (e) => e.toString() == 'ContactType.${json['type']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'type': type.toString().split('.').last,
    };
  }
}