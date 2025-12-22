class Offer {
  final int id;
  final String imageUrl;
  final String title;
  final OfferActionType actionType;
  final String actionId;
  final DateTime startedDate;
  final DateTime endDate;

  Offer(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.actionType,
      required this.actionId,
      required this.startedDate,
      required this.endDate});
}

enum OfferActionType { product, category, store, none }
