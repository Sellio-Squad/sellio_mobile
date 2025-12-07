String formatPrice(String price) {
  if(price[0] == '\$') {
    price = price.substring(1);
  }else if (price[0] == 'U') {
    price = price.substring(3);
  }
  final value = double.tryParse(price) ?? 0.0;
  return value.toStringAsFixed(1);
}
