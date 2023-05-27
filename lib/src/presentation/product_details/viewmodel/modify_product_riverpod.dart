import 'package:ecommercebusiness/src/data/datasource/web_services/modify_product_webservices.dart';
import 'package:ecommercebusiness/src/data/datasource/web_services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/modify_product_repository.dart';

final modifyProduct = ChangeNotifierProvider((ref) => ModifyProductRiverpod(
    ModifyProductRepository(ModifyProductWebServices(WebServices()))));

class ModifyProductRiverpod extends ChangeNotifier {
  final ModifyProductRepository modifyProductRepository;

  ModifyProductRiverpod(this.modifyProductRepository);

  Future<Map<String, dynamic>> updateProduct(
      {required String id,
      required title,
      required price,
      required description,
      required imagePath,
      required category}) {
    return modifyProductRepository.updateProduct(
        id, title, price, description, imagePath, category);
  }

  Future<Map<String, dynamic>> createProduct(
      {required String id,
      required title,
      required price,
      required description,
      required imagePath,
      required category}) {
    return modifyProductRepository.createProduct(
        id, title, price, description, imagePath, category);
  }

  Future<Map<String, dynamic>> deleteProduct({
    required String id,
  }) {
    return modifyProductRepository.deleteProduct(id);
  }
}
