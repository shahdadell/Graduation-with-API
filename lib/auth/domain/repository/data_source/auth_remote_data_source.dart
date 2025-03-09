// import 'package:graduation_project/data/response/RegisterResponse.dart';

import '../../../data/model/response/RegisterResponse.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResultEntity> register(
      String username, String password, String email, String phone);

  Future<AuthResultEntity> login(String username, String password);
  Future<AuthResultEntity> verifyCode(String email, String verifyCode);
}
