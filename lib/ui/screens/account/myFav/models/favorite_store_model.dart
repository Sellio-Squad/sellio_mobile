
import '../../../home/widgets/top_stores/top_stores_section.dart';

class FavoriteStore extends Store {
  FavoriteStore({
    required super.id,
    required super.name,
    required super.imageUrl,
    super.discount,
    super.coverImage,
    super.profileImage,
    super.rating,
    super.isFavorite,
  });
}
