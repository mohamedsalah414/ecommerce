import 'package:dio/dio.dart';
import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/modules/profile/data/model/user/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/shared_preferences.dart';
import '../../../../../core/utils/app_strings.dart';

class LogInWebServices {
  final WebServices webServices;

  LogInWebServices(this.webServices);
  Future<Response> logIn(String username, String pass) async {
    final Response response = await webServices.dio.post(
        AppStrings.loginEndPoint,
        data: {'username': username, 'password': pass});
    SharedPreferencesService.getInstance().then((service) {
      service.saveValue('token', response.data['token']);
    });
    debugPrint('response is $response');

    return response;
  }

  Future<UserModel> fetchUser() async {
    try {
      final Response response = await webServices.dio.get(
        '${AppStrings.usersEndPoint}/1',
      );

      final data = response.data;
      debugPrint(data.toString());
      return UserModel.fromJson(data);
    } catch (e) {
      debugPrint('fetchUser error is $e');
      return Future.error(e);
    }
  }
}
