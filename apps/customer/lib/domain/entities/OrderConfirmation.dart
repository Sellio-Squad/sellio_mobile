class OrderConfirmation {
  final String message;
  final List<String> orderIds;

  const OrderConfirmation({
    required this.message,
    required this.orderIds,
  });
}