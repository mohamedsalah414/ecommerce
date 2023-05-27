import 'package:ecommercebusiness/src/data/datasource/web_services/product_web_services.dart';
import 'package:ecommercebusiness/src/data/model/product_model.dart';

class ProductRepository {
  final ProductWebServices productWebServices;

  ProductRepository(this.productWebServices);

  Future<List<ProductModel>> getAllProducts(sort, limit) async {
    final List<ProductModel> products =
        await productWebServices.getAllProducts(sort, limit);
    return products;
  }

  Future<List<ProductModel>> getAllProductsBySorting(
      category, sort, limit) async {
    final List<ProductModel> products =
        await productWebServices.getAllProductsBySorting(category, sort, limit);
    return products;
  }

  Future<ProductModel> getOneProduct(id) async {
    final ProductModel product = await productWebServices.getOneProduct(id);
    return product;
  }

  Future<List<String>> getAllCategories() async {
    final List<String> categories = await productWebServices.getAllCategories();
    return categories;
  }
}
