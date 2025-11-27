extension ProductPriceExtensions on double {
  String oldPrice(int? discountPercentage) {
    if (discountPercentage == null || discountPercentage <= 0) {
      return toStringAsFixed(2);
    }
    final double originalPrice = this / (1 - discountPercentage / 100);
    return originalPrice.toStringAsFixed(2);
  }
}
