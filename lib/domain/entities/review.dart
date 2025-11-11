// review.dart
class Review {
  final String id;
  final String storeId;
  final String userId;
  final String userName;
  final String? userImage;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.storeId,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  Review copyWith({
    String? id,
    String? storeId,
    String? userId,
    String? userName,
    String? userImage,
    double? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Review.dummy({int index = 0, String storeId = 'store_0'}) {
    return Review(
      id: 'review_$index',
      storeId: storeId,
      userId: 'user_$index',
      userName: 'User #$index',
      userImage: 'https://picsum.photos/seed/user_$index/100',
      rating: 3.5 + (index % 2),
      comment: 'Great store! I really liked their service and products.',
      createdAt: DateTime.now().subtract(Duration(days: index * 2)),
    );
  }

  static List<Review> dummyList({int count = 5, String storeId = 'store_0'}) {
    return List.generate(count, (i) => Review.dummy(index: i, storeId: storeId));
  }
}
