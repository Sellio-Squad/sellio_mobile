class FavoriteStore {
  final String id;           
  final String name;         
  final String imageUrl;     
  final String? discount;    
  final String? coverImage;  
  final String? profileImage;
  final double rating;       
  bool isFavorite;

  FavoriteStore({
    required this.id,           
    required this.name,         
    required this.imageUrl,     
    this.discount,
    this.coverImage,
    this.profileImage,
    this.rating = 0.0,
    this.isFavorite = false,
  });

  FavoriteStore copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? discount,
    String? coverImage,
    String? profileImage,
    double? rating,
    bool? isFavorite,
  }) {
    return FavoriteStore(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      coverImage: coverImage ?? this.coverImage,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}