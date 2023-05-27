import 'package:dio/dio.dart';
import 'package:ecommercebusiness/src/data/datasource/web_services/logIn_web_services.dart';
import 'package:ecommercebusiness/src/data/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/data/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final login = ChangeNotifierProvider(
    (ref) => LogInRiverpod(LoginRepository(LogInWebServices(WebServices()))));

class LogInRiverpod extends ChangeNotifier {
  final LoginRepository loginRepository;

  LogInRiverpod(this.loginRepository);

  Future<Response> logIn(
    String email,
    String pass,
  ) async {
    final Response response = await loginRepository.logIn(email, pass);
    return response;
  }
}
