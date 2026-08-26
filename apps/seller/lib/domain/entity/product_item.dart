import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final double price;
  final String discountId;
  final String? colorId;
  final String? sizeId;
  final int weightId;
  final int stock;

  const ProductItem({
    required this.price,
    this.discountId = '',
    this.colorId = '',
    this.sizeId = '',
    required this.weightId,
    required this.stock,
  });

  @override
  List<Object?> get props => [
        price,
        discountId,
        colorId,
        sizeId,
        weightId,
        stock,
      ];

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'discountId': discountId,
      'colorId': colorId,
      'sizeId': sizeId,
      'weightId': weightId,
      'stock': stock,
    };
  }
}
