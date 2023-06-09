import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/datasource/web_services/product_web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/model/product/product_model.dart';
import 'package:ecommercebusiness/src/modules/home/data/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeScreenProducts =
    FutureProvider.family<List<ProductModel>, Map<String, String>>(
  (ref, params) async {
    final productsRiverPod = HomeScreenProductsRiverPod(
      ProductRepository(ProductWebServices(WebServices())),
    );
    final sort = params['sort'];
    final category = params['category'];
    final limit = params['limit'];
    final data = category == 'all'
        ? await productsRiverPod.getAllProducts(sort, limit)
        : await productsRiverPod.getAllProductsBySorting(category, sort, limit);

    return data;
  },
);

class HomeScreenProductsRiverPod {
  final ProductRepository productRepository;

  HomeScreenProductsRiverPod(this.productRepository);

  Future<List<ProductModel>> getAllProducts(sort, limit) async {
    return productRepository.getAllProducts(sort, limit);
  }

  Future<List<ProductModel>> getAllProductsBySorting(
      category, sort, limit) async {
    return productRepository.getAllProductsBySorting(category, sort, limit);
  }
}
