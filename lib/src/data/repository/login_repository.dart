import 'package:dio/dio.dart';
import 'package:ecommercebusiness/src/data/model/user/user_model.dart';

import '../datasource/web_services/logIn_web_services.dart';

class LoginRepository {
  final LogInWebServices logInWebServices;

  LoginRepository(this.logInWebServices);

  Future<Response> logIn(String email, String pass) async {
    return await logInWebServices.logIn(email, pass);
  }

  Future<UserModel> fetchUser() async {
    return await logInWebServices.fetchUser();
  }
}
