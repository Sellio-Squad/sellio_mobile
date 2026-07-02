class StoreCreationResponse {
  final String id;
  final String title;
  final String ownerId;
  final String avatarUrl;
  final String coverUrl;
  final String createdAt;

  StoreCreationResponse({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.avatarUrl,
    required this.coverUrl,
    required this.createdAt,
  });

  factory StoreCreationResponse.fromJson(Map<String, dynamic> json) {
    return StoreCreationResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      ownerId: json['ownerId'] as String,
      avatarUrl: json['avatarUrl'] as String,
      coverUrl: json['coverUrl'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
}
