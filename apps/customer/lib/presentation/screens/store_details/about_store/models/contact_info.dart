
enum ContactType { email, phone, facebook, whatsapp, website}

class ContactInfo {
  final String title;
  final String provider;
  final ContactType type;
  final String icon;
  ContactInfo({
    required this.title,
    required this.provider,
    required this.type,
    required this.icon,
  });
}
