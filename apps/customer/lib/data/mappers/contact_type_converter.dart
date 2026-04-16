import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/store.dart';

class ContactTypeConverter implements JsonConverter<ContactType, String> {
  const ContactTypeConverter();

  @override
  ContactType fromJson(String json) {
    return ContactType.values.firstWhere(
      (e) => e.toString().split('.').last == json,
    );
  }

  @override
  String toJson(ContactType type) => type.toString().split('.').last;
}
