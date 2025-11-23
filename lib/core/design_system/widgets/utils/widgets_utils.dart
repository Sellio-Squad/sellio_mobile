String formatPrice(String price) {
  final value = double.tryParse(price) ?? 0.0;
  return value.toStringAsFixed(1);
}
