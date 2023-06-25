import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/datasource/web_services/product_web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/model/product/product_model.dart';
import 'package:ecommercebusiness/src/modules/home/data/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
