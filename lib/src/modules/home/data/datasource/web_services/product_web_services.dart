import 'package:dio/dio.dart';
import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/modules/home/data/model/product/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_strings.dart';

class ProductWebServices {
  final WebServices webServices;

  ProductWebServices(this.webServices);

  Future<List<ProductModel>> getAllProducts(String sort, String limit) async {
    try {
      final Response response = await webServices.dio
          .get(AppStrings.productsEndPoint, queryParameters: {
        'sort': sort,
        'limit': limit,
      });

      debugPrint('response is $response');

      List<ProductModel> products =
          (response.data as List<dynamic>).map((dynamic product) {
        return ProductModel.fromJson(
            product); // Assuming you have a fromJson() method in your ProductModel class
      }).toList();

      return products;
    } catch (e) {
      debugPrint('getAllProducts error is $e');
      return [];
    }
  }

  Future<List<ProductModel>> getAllProductsBySorting(
      String category, String sort, String limit) async {
    try {
      final Response response = await webServices.dio.get(
          '${AppStrings.categorySortProductsEndPoint}/$category',
          queryParameters: {
            'sort': sort,
            'limit': limit,
          });

      debugPrint('response is $response');

      List<ProductModel> products =
          (response.data as List<dynamic>).map((dynamic product) {
        return ProductModel.fromJson(
            product); // Assuming you have a fromJson() method in your ProductModel class
      }).toList();

      return products;
    } catch (e) {
      debugPrint('getAllProducts error is $e');
      return [];
    }
  }

  Future<ProductModel> getOneProduct(String id) async {
    try {
      Response response = await webServices.dio.get(
        '${AppStrings.productsEndPoint}/$id',
      );
      debugPrint('response is $response');

      ProductModel product = ProductModel.fromJson(response.data);

      return product;
    } catch (e) {
      debugPrint('getOneProduct error is $e');
      return Future.error(e);
    }
  }

  Future<List<String>> getAllCategories() async {
    try {
      final Response response = await webServices.dio
          .get(AppStrings.productsEndPoint + AppStrings.categoriesEndPoint);

      debugPrint('response is $response');

      List<dynamic> jsonList = response.data as List<dynamic>;
      List<String> categories =
          jsonList.map((dynamic category) => category.toString()).toList();

      return categories;
    } catch (e) {
      debugPrint('getAllCategories error is $e');
      return [];
    }
  }
}
