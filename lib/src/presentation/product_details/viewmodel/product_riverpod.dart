import 'package:ecommercebusiness/src/data/datasource/web_services/product_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/web_services/web_services.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repository/products_repository.dart';

final productDetailsScreenProducts =
    FutureProvider.family.autoDispose<ProductModel, String>((ref, id) async {
  final productDetailsRiverPod = ProductDetailsProductsRiverPod(
      ProductRepository(ProductWebServices(WebServices())));
  final data = await productDetailsRiverPod.getOneProduct(id);
  return data;
});

class ProductDetailsProductsRiverPod {
  final ProductRepository productRepository;

  ProductDetailsProductsRiverPod(this.productRepository);

  Future<ProductModel> getOneProduct(id) async {
    return productRepository.getOneProduct(id);
  }
}
