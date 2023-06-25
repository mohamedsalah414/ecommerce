import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/datasource/web_services/product_web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categories = FutureProvider<List<String>>((ref) async {
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
