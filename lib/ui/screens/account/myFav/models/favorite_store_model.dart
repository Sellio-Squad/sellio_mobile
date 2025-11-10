
import '../../../home/widgets/top_stores/top_stores_section.dart';

class FavoriteStore extends Store {
  FavoriteStore({
    required String id,
    required String name,
    required String imageUrl,
    String? discount,
    String? coverImage,
    String? profileImage,
    double? rating,
    bool isFavorite = false,
  }) : super(
    id: id,
    name: name,
    imageUrl: imageUrl,
    discount: discount,
    coverImage: coverImage,
    profileImage: profileImage,
    rating: rating,
    isFavorite: isFavorite,
  );
}
