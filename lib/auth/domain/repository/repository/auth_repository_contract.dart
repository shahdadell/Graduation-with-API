import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';

abstract class AuthRepositoryContract {
  Future<AuthResultEntity> register(
      String username, String password, String email, String phone);

  Future<AuthResultEntity> login(String email, String password);
}
