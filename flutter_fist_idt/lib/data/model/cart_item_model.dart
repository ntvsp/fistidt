import 'product.dart';

class CartItemModel {
  int? quantity;
  final ProductModel? product;

  CartItemModel({this.quantity, this.product});

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        quantity: json['quantity'] as int?,
        product: json['product'] == null
            ? null
            : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'product': product?.toJson(),
      };
}
