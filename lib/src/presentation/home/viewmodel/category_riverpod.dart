import 'package:ecommercebusiness/src/data/datasource/web_services/product_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/web_services/web_services.dart';
import '../../../data/repository/products_repository.dart';

final categories = FutureProvider.autoDispose<List<String>>((ref) async {
  final categoriesRiverPod =
      CategoriesRiverPod(ProductRepository(ProductWebServices(WebServices())));
  final data = await categoriesRiverPod.getAllCategories();
  return data;
});

class CategoriesRiverPod {
  final ProductRepository productRepository;

  CategoriesRiverPod(this.productRepository);

  Future<List<String>> getAllCategories() async {
    return productRepository.getAllCategories();
  }
}
