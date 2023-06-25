import 'package:ecommercebusiness/src/modules/home/data/model/product/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;
  final int userId;
  final DateTime date;
  final List<OrderProductModel> products;

  OrderModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class OrderProductModel {
  final int productId;
  final int quantity;
  final ProductModel product;

  OrderProductModel({
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}
