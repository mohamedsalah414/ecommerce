import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ModifyProductWebServices {
  final WebServices webServices;

  ModifyProductWebServices(this.webServices);

  Future<Map<String, dynamic>> updateProduct(
      String id, title, price, description, imagePath, category) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };

      /// ignore this block fo code to can return result from fake api but if i want to upload from device I will use it
      // final formData = FormData.fromMap({
      //   'title': title,
      //   'price': price,
      //   'description': description,
      //   'category': category,
      // });
      //
      // final file = await MultipartFile.fromFile(
      //   imagePath.path,
      //   filename: imagePath.path.split('/').last,
      // );
      // formData.files.add(MapEntry('image', file));

      var body = json.encode({
        "title": title,
        "price": price,
        "description": description,
        "image": "https://i.pravatar.cc",
        "category": category
      });
      final Response response = await webServices.dio.patch(
        '${AppStrings.productsEndPoint}/$id',
        data: body,
        options: Options(headers: headers),
      );

      debugPrint('response is ${response.data}');

      return response.data;
    } catch (e) {
      debugPrint('updateProduct error is $e');
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> createProduct(
      String id, title, price, description, imagePath, category) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "title": title,
        "price": price,
        "description": description,
        "image": "https://i.pravatar.cc",
        "category": category
      });
      final Response response = await webServices.dio.post(
        AppStrings.productsEndPoint,
        data: body,
        options: Options(headers: headers),
      );

      debugPrint('response is ${response.data}');

      return response.data;
    } catch (e) {
      debugPrint('createProduct error is $e');
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      final Response response = await webServices.dio.delete(
        '${AppStrings.productsEndPoint}/$id',
      );

      debugPrint('response is ${response.data}');

      return response.data;
    } catch (e) {
      debugPrint('createProduct error is $e');
      return Future.error(e);
    }
  }
}
