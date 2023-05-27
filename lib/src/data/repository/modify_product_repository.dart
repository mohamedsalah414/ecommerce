import '../datasource/web_services/modify_product_webservices.dart';

class ModifyProductRepository {
  final ModifyProductWebServices modifyProductWebServices;

  ModifyProductRepository(this.modifyProductWebServices);

  Future<Map<String, dynamic>> updateProduct(
      String id, title, price, description, imagePath, category) {
    return modifyProductWebServices.updateProduct(
        id, title, price, description, imagePath, category);
  }

  Future<Map<String, dynamic>> createProduct(
      String id, title, price, description, imagePath, category) {
    return modifyProductWebServices.createProduct(
        id, title, price, description, imagePath, category);
  }

  Future<Map<String, dynamic>> deleteProduct(String id) {
    return modifyProductWebServices.deleteProduct(id);
  }
}
