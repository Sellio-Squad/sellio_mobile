class FavoriteStore {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String discount;
  bool isFavorite;

  FavoriteStore({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.discount,
    this.isFavorite = false,
  });
}
