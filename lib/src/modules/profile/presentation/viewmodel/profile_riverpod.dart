import 'package:ecommercebusiness/src/config/datasource/web_services/web_services.dart';
import 'package:ecommercebusiness/src/modules/login/data/datasource/web_services/logIn_web_services.dart';
import 'package:ecommercebusiness/src/modules/login/data/repository/login_repository.dart';
import 'package:ecommercebusiness/src/modules/profile/data/model/user/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
