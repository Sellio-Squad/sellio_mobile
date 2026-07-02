class CreateStoreRequest {
  final String title;
  final String description;
  final String phoneNumber;
  final String city;
  final String government;
  final String country;
  final String avatarImageURL;
  final String coverImageURL;

  CreateStoreRequest({
    required this.title,
    required this.description,
    required this.phoneNumber,
    required this.city,
    required this.government,
    required this.country,
    required this.avatarImageURL,
    required this.coverImageURL,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'phoneNumber': phoneNumber,
      'city': city,
      'government': government,
      'country': country,
      'avatarImageURL': avatarImageURL,
      'coverImageURL': coverImageURL,
    };
  }
}
