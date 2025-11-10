class FavoriteProduct {
  final int id;
  final String imageUrl;
  final String title;
  final String price;
  bool isFavorite;

  FavoriteProduct({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.isFavorite = false,
  });
}
