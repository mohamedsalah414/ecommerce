import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart'; // This is the generated file

@JsonSerializable() // Add this annotation to the class
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json); // Generated factory method

  Map<String, dynamic> toJson() =>
      _$ProductModelToJson(this); // Generated method
}

@JsonSerializable() // Add this annotation to the class
class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      _$RatingFromJson(json); // Generated factory method

  Map<String, dynamic> toJson() => _$RatingToJson(this); // Generated method
}
