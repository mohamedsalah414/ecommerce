import 'package:ecommercebusiness/src/data/datasource/web_services/logIn_web_services.dart';
import 'package:ecommercebusiness/src/data/model/user_model.dart';
import 'package:ecommercebusiness/src/data/repository/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/web_services/web_services.dart';

final profileDetails = FutureProvider.autoDispose<UserModel>((ref) async {
  final profileDetailsRiverPod =
      ProfileDetailsRiverPod(LoginRepository(LogInWebServices(WebServices())));
  final data = await profileDetailsRiverPod.fetchUser();
  return data;
});

class ProfileDetailsRiverPod {
  final LoginRepository loginRepository;

  ProfileDetailsRiverPod(this.loginRepository);

  Future<UserModel> fetchUser() async {
    return loginRepository.fetchUser();
  }
}
