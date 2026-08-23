class StoreCreationResponse {
  final String id;
  final String title;
  final String avatarUrl;
  final String coverUrl;
  final String createdAt;

  StoreCreationResponse({
    required this.id,
    required this.title,
    required this.avatarUrl,
    required this.coverUrl,
    required this.createdAt,
  });

  factory StoreCreationResponse.fromJson(Map<String, dynamic> json) {
    return StoreCreationResponse(
      id: (json['id'] ?? json['_id'])?.toString() ?? '',
      title: (json['title'] ?? json['name'])?.toString() ?? '',
      avatarUrl:
          (json['avatarImageURL'] ?? json['avatarUrl'])?.toString() ?? '',
      coverUrl: (json['coverImageURL'] ?? json['coverUrl'])?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
