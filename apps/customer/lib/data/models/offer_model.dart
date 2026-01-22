import 'package:sellio_mobile/domain/entities/offer.dart';

class OfferModel {
  final int id;
  final String? imageUrl;
  final String? title;
  final String? actionType;
  final String? actionId;
  final DateTime? startedDate;
  final DateTime? endDate;

  OfferModel(
      {required this.id,
      this.imageUrl,
      this.title,
      this.actionType,
      this.actionId,
      this.startedDate,
      this.endDate});

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      actionType: json['actionType'],
      actionId: json['actionId'],
      startedDate: json['startedDate'] != null
          ? DateTime.tryParse(json['startedDate'])
          : null,
      endDate:
          json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
    );
  }

  Offer toEntity() {
    return Offer(
      id: id,
      imageUrl: imageUrl ?? "",
      title: title ?? "",
      actionType: _mapActionType(actionType ?? OfferActionType.none.name),
      actionId: actionId ?? "",
      startedDate: startedDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now().add(const Duration(days: 2)),
    );
  }

  OfferActionType _mapActionType(String value) {
    switch (value.toUpperCase()) {
      case 'PRODUCT':
        return OfferActionType.product;
      case 'CATEGORY':
        return OfferActionType.category;
      case 'STORE':
        return OfferActionType.store;
      default:
        return OfferActionType.none;
    }
  }
}
