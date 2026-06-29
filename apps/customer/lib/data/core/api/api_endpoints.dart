class ApiEndpoints {
  ApiEndpoints._();

  // Base
  static const String baseUrl = 'https://app.sell-io.app';

  // API Version
  static const String apiVersion = '/v1';

  // User
  static const String userInsert = '$apiVersion/user/insert';

  // Products
  static const String products = '$apiVersion/products';
  static const String productsUsed = '$apiVersion/products/used';
  static const String productsFeatured = '$apiVersion/products/featured';
  static const String productsSearch = '$apiVersion/products/search';
  static const String productsTrending = '$apiVersion/product-items/trending';

  static String productById(String productId) =>
      '$apiVersion/products/$productId';

  static String productsByStore(String storeId) =>
      '$apiVersion/products/store/$storeId';

  static String productsByCategory(String categoryId) =>
      '$apiVersion/products/category/$categoryId';

  static String productsUsedByCategory([String? categoryId]) {
    if (categoryId != null && categoryId.isNotEmpty) {
      return '$apiVersion/products/used?category=$categoryId';
    }
    return productsUsed;
  }

  // Stores
  static const String stores = '$apiVersion/stores';
  static const String storesCreate = '$apiVersion/stores/create';
  static const String storesTopRating = '$apiVersion/stores/top-rating';
  static const String storesSearch = '$apiVersion/stores/search';

  static String storeById(String storeId) => '$apiVersion/stores/$storeId';

  static String storeDetails(String storeId) =>
      '$apiVersion/stores/store-details/$storeId';

  static String storeImages(String storeId) =>
      '$apiVersion/stores/$storeId/images';

  // Categories
  static const String categoriesAll = '$apiVersion/category/all-categories';
  static const String categoryCreate = '$apiVersion/category/create';

  static String categoryById(String categoryId) =>
      '$apiVersion/category/$categoryId';

  // SubCategories
  static const String subCategoriesCreate = '$apiVersion/subcategories/create';

  static String subCategoriesByStore(String storeId) =>
      '$apiVersion/subcategories/store/$storeId';

  static String subCategoriesByCategory(String categoryId) =>
      '$apiVersion/subcategories/category/$categoryId';

  static String productsBySubcategory(String subcategoryId) =>
      '$apiVersion/products/subcategory/$subcategoryId';

  // Cart
  static String cart(String userId) => '$apiVersion/cart/$userId';
  static const String cartAdd = '$apiVersion/cart/add';
  static const String cartRemove = '$apiVersion/cart/remove';
  static const String cartUpdate = '$apiVersion/cart/update';

  static String cartClear(String userId) => '$apiVersion/cart/$userId/clear';

  // Orders
  static const String orders = '$apiVersion/orders';
  static const String orderConfirm = '$apiVersion/orders/confirm';
  static const String ordersHistory = '$apiVersion/orders/history';

  static String orderById(String orderId) => '$apiVersion/orders/$orderId';

  static String orderCancel(String orderId) =>
      '$apiVersion/orders/$orderId/cancel';

  // Favorites
  static const String favoriteProducts = '$apiVersion/favorite-products';
  static const String favoriteStores = '$apiVersion/favorite-stores';

  static String favoriteProductToggle(String productId) =>
      '$apiVersion/favorite-products/toggle/$productId';

  static String favoriteStoreToggle(String storeId) =>
      '$apiVersion/favorite-stores/toggle/$storeId';

  // Discounts
  static const String discounts = '$apiVersion/discounts';

  static String discountsByStore(String storeId) =>
      '$apiVersion/discounts/store/$storeId';

  static String discountsByCategory(String categoryId) =>
      '$apiVersion/discounts/category/$categoryId';

  static String discountsBySubCategory(String subCategoryId) =>
      '$apiVersion/discounts/sub-category/$subCategoryId';

  static String discountsByProduct(String productId) =>
      '$apiVersion/discounts/product/$productId';

  static String discountById(String discountId) =>
      '$apiVersion/discounts/$discountId';

  //Offers
  static const String offers = '$apiVersion/offers';

  // Store Rating
  static String storeRating(String storeId) =>
      '$apiVersion/store-rating/$storeId';

  // Store Reviews
  static const String storeReviews = '$apiVersion/store-reviews';

  static String storeReviewsByStore(String storeId) =>
      '$apiVersion/store-reviews/$storeId';

  // Category Sections
  static const String categorySectionsActive =
      '$apiVersion/category-sections/active';
}
