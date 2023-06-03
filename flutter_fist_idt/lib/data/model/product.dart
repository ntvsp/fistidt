import 'package:flutter_fist_idt/data/model/user_model.dart';

class ProductModel {
  int? id;
  UserModel? owner;
  String? name;
  dynamic description;
  dynamic price;
  dynamic image;

  ProductModel({
    this.id,
    this.owner,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        owner: json['owner'] == null
            ? null
            : UserModel.fromJson(json['owner'] as Map<String, dynamic>),
        name: json['name'] as String?,
        description: json['description'] as dynamic,
        price: json['price'] as dynamic,
        image: json['image'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner?.toJson(),
        'name': name,
        'description': description,
        'price': price,
        'image': image,
      };
}
